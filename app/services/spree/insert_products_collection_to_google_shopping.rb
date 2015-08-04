module Spree
  class InsertProductsCollectionToGoogleShopping
    
    def self.call(products, google_shopping_integration)
      variants = products.includes(:taxons, master: [:images, :stock_items, :default_price], variants: [:images, :stock_items, :default_price]).flat_map do |p|
        p.variants.any? ? p.variants : p.master
      end
      @google_shopping_items = GoogleShoppingItem.wrap(variants)
      @google_shopping_integration = google_shopping_integration
      entries = @google_shopping_items.map { |item| bulk_attributes(item) }
      success?(google_shopping_client.batch_operation(entries))
    end
    
    private
    
    def self.google_shopping_client
      @google_shopping_integration.client
    end
    
    def self.bulk_attributes(google_shopping_item)
      {
        merchantId: @google_shopping_integration.merchant_id,
        batchId: google_shopping_item.id, 
        method: determine_action(google_shopping_item),
        product: google_shopping_item.to_request.merge({
          channel: @google_shopping_integration.channel,
          contentLanguage: @google_shopping_integration.content_language,
          targetCountry: @google_shopping_integration.target_country,
          link: [@google_shopping_integration.url, route_helpers.product_path(google_shopping_item.product)].join
        })
      }
    end
  
    def self.determine_action(google_shopping_item)
      if google_shopping_item.product.available_on.nil? || google_shopping_item.product.available_on > Time.now
        'delete'
      else
        'insert'
      end
    end
    
    def self.route_helpers
      Spree::Core::Engine.routes.url_helpers
    end
    
    def self.success?(message)
      message.response.status == 200
    end
  end
end
