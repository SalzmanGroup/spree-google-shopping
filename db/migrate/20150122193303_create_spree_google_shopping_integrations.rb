class CreateSpreeGoogleShoppingIntegrations < ActiveRecord::Migration
  def change
    create_table :spree_google_shopping_integrations do |t|
      t.string :name
      t.string :version
      t.string :merchant_id
      t.string :channel
      t.string :content_language
      t.string :target_country
      t.string :url
      t.boolean :active
      t.boolean :test

      t.timestamps
    end
    
    add_reference :spree_google_shopping_integrations, :products_scope, index: false, polymorphic: true
    add_index :spree_google_shopping_integrations, [:products_scope_id, :products_scope_type], name: 'shopping_integrations_products_scopes_index'
  end
end
