namespace :spree_google_shopping do
  task bulk_insert: :environment do
    Spree::GoogleShoppingIntegration.active.each do |integration|
      puts "Inserting products for #{integration.name}"
      begin
        Spree::InsertProductsCollectionToGoogleShopping.call(integration.products, integration)
      rescue StandardError => e
        puts "Failed to import due to exceptions: #{e.message}"
      end
    end
  end
end
