namespace :spree_google_shopping do
  task bulk_insert: :environment do
    batch_size = Spree::Config.google_shopping_batch_size
    Spree::GoogleShoppingIntegration.active.each do |integration|
      puts "Inserting products for #{integration.name}"
      product_count = integration.products.count
      i = 0
      while (i * batch_size) < product_count
        begin
          puts "-- Batch #{i + 1}"
          products = integration.products
          if Spree::InsertProductsCollectionToGoogleShopping.call(products.limit([i * batch_size, batch_size].join(',')), integration)
            puts "-- Success!"
          else
            puts "The server returned an error when attempting to insert"
          end
        rescue StandardError => e
          puts "Failed to insert due to exceptions: #{e.message}"
        end
        i += 1
      end
    end
  end
end
