class Spree::GoogleShoppingIntegration < ActiveRecord::Base
  CHANNELS = %w{online local}

  belongs_to :products_scope, polymorphic: true

  has_and_belongs_to_many :taxons

  validates :name, presence: true
  validates :merchant_id, presence: true
  validates :channel, presence: true, inclusion: { in: CHANNELS }
  validates :content_language, presence: true
  validates :target_country, presence: true
  validates :active, presence: true

  scope :active, -> { where(active: true) }

  def self.channel_options
    CHANNELS
  end

  def products
    Spree::Product.where :gs_enabled => true
  end

  def client
    @_client ||= SpreeGoogleShopping::Client.new(
      private_key_path: private_key_path,
      private_key_password: private_key_password,
      service_account_email: service_account_email,
      application_name: name,
      application_version: version,
      params: {
        merchantId: merchant_id,
        dryRun: test?,
      }
    )
  end
end
