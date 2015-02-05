module Spree
  class InsertVariantToGoogleShopping
    
    def self.call(variant, google_shopping_integration)
      @variant = variant
      @google_shopping_item = GoogleShoppingItem.new(@variant)
      @google_shopping_integration = google_shopping_integration
      success?(google_shopping_client.insert(base_attributes.merge(@google_shopping_item.to_request)))
    end
    
    private
    
    def self.google_shopping_client
      @google_shopping_integration.client
    end
    
    def self.base_attributes
      {
        channel: @google_shopping_integration.channel,
        contentLanguage: @google_shopping_integration.content_language,
        targetCountry: @google_shopping_integration.target_country,
        link: [@google_shopping_integration.url, route_helpers.product_path(@variant.product)].join
      }
    end
    
    def self.route_helpers
      Spree::Core::Engine.routes.url_helpers
    end
    
    def self.success?(message)
      message.response.status == 200
    end
  end
end
