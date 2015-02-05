namespace :spree_google_shopping do
  task bulk_insert: :environment do
    Spree::GoogleShoppingIntegration.active.each do |integration|
      puts "Inserting products for #{integration.name}"
      begin
        if Spree::InsertProductsCollectionToGoogleShopping.call(integration.products, integration)
          puts "-- Success!"
        else
          puts "The server returned an error when attempting to insert"
        end
      rescue StandardError => e
        puts "Failed to insert due to exceptions: #{e.message}"
      end
    end
  end
end
