class AddProductsScopeToSpreeGoogleShoppingIntegrations < ActiveRecord::Migration
  def change
    add_reference :spree_google_shopping_integrations, :products_scope, index: false, polymorphic: true
    add_index :spree_google_shopping_integrations, [:products_scope_id, :products_scope_type], name: 'shopping_integrations_products_scopes_index'
  end
end
