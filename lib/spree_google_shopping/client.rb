require 'google/api_client'

module SpreeGoogleShopping
  class Client
    REQUIRED_ATTRIBUTES = %i{private_key_password service_account_email}
    SCOPE = 'https://www.googleapis.com/auth/content'
    API_VERSION = 'v2'
    
    attr_reader :api_client, :opts
    
    def initialize(options={})
      options[:private_key_path] ||= ENV['SPREE_GOOGLE_SHOPPING_PRIVATE_KEY_PATH'] || [Rails.root, 'config', 'google_shopping_key.p12'].join('/')
      options[:private_key_password] ||= ENV['SPREE_GOOGLE_SHOPPING_PRIVATE_KEY_PASSWORD']
      options[:service_account_email] ||= ENV['SPREE_GOOGLE_SHOPPING_SERVICE_ACCOUNT_EMAIL']
      options[:application_name] ||= ENV['SPREE_GOOGLE_SHOPPING_APPLICATION_NAME']
      options[:application_version] ||= ENV['SPREE_GOOGLE_SHOPPING_APPLICATION_VERSION']
      
      validate_attributes!(options)
      @opts = options
      connect!
    end
    
    def insert(params)
      log_message api_client.execute(
        api_method: shopping_api.products.insert,
        parameters: opts[:params],
        body_object: params
      )
    end
    
    def batch_operation(params)
      log_message api_client.execute(
        api_method: shopping_api.products.custombatch,
        parameters: opts[:params],
        body_object: {
          entries: params
        }
      )
    end
    
    private

    def log_message(message)
      logger = Logger.new('log/spree_google_shopping.log')
      logger.info message.response
      message
    end
    
    def connect!
      @api_client = Google::APIClient.new(
        application_name: opts[:application_name],
        application_version: opts[:application_version]
      )
      
      key = Google::APIClient::KeyUtils.load_from_pkcs12(opts[:private_key_path], opts[:private_key_password])
      
      api_client.authorization = authorize(key)
      api_client.authorization.fetch_access_token!
    end
    
    def validate_attributes!(options)
      missing_attributes = REQUIRED_ATTRIBUTES.select { |a| options[a].nil? }
      if missing_attributes.any?
        raise ClientAttributeMissingError.new(missing_attributes)
      end
    end
    
    def authorize(key)
      Signet::OAuth2::Client.new(
        :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
        :audience => 'https://accounts.google.com/o/oauth2/token',
        :scope => SCOPE,
        :issuer => opts[:service_account_email],
        :signing_key => key
      )
    end
    
    def shopping_api
      Rails.cache.fetch([self, 'shopping_api']) {
        api_client.discovered_api('content', API_VERSION)
      }
    end
  end
  
  class ClientAttributeMissingError < StandardError
    attr_accessor :attributes
    
    def initialize(attributes)
      self.attributes = Array.wrap(attributes).join(', ')
    end
    
    def message
      I18n.t(:missing_attributes, scope: :spree_google_shopping_client, attributes: attributes)
    end
  end
end
