class AddActiveToSpreeGoogleShoppingIntegrations < ActiveRecord::Migration
  def change
    add_column :spree_google_shopping_integrations, :active, :boolean
  end
end
