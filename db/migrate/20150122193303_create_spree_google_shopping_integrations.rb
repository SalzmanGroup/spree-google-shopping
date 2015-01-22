class CreateSpreeGoogleShoppingIntegrations < ActiveRecord::Migration
  def change
    create_table :spree_google_shopping_integrations do |t|
      t.string :name
      t.string :merchant_id
      t.string :channel
      t.string :content_language
      t.string :target_country

      t.timestamps
    end
  end
end
