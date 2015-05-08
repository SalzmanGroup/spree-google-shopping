class AddStoreSpecificAttributesToSpreeGoogleShoppingIntegrations < ActiveRecord::Migration
  def change
    add_column :spree_google_shopping_integrations, :private_key_path, :string
    add_column :spree_google_shopping_integrations, :private_key_password, :string
    add_column :spree_google_shopping_integrations, :service_account_email, :string
  end
end
