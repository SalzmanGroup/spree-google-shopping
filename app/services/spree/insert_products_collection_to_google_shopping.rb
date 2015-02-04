module Spree
  class InsertProductsCollectionToGoogleShopping
    
    def self.call(products, google_shopping_integration)
      variants = products.includes(:variants, :master, :taxons).flat_map do |p|
        p.variants.any? ? p.variants : p.master
      end
      @google_shopping_items = GoogleShoppingItem.wrap(variants)
      @google_shopping_integration = google_shopping_integration
      entries = @google_shopping_items.map { |item| bulk_attributes(item) }
      google_shopping_client.batch_operation(entries)
    end
    
    private
    
    def self.google_shopping_client
      @google_shopping_integration.client
    end
    
    def self.bulk_attributes(google_shopping_item)
      {
        merchantId: @google_shopping_integration.merchant_id,
        batchId: google_shopping_item.id, 
        method: 'insert',
        product: google_shopping_item.to_request.merge({
          channel: @google_shopping_integration.channel,
          contentLanguage: @google_shopping_integration.content_language,
          targetCountry: @google_shopping_integration.target_country,
          link: [@google_shopping_integration.url, route_helpers.product_path(google_shopping_item.product)].join
        })
      }
    end
    
    def self.route_helpers
      Spree::Core::Engine.routes.url_helpers
    end
  end
end
