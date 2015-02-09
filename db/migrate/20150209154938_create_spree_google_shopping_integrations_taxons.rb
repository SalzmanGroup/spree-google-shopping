class CreateSpreeGoogleShoppingIntegrationsTaxons < ActiveRecord::Migration
  def change
    create_table :spree_google_shopping_integrations_taxons do |t|
      t.integer :google_shopping_integration_id
      t.integer :taxon_id
    end
    
    add_index(:spree_google_shopping_integrations_taxons, [:google_shopping_integration_id, :taxon_id], unique: true, name: 'google_shopping_integrations_taxons_index')
  end
end
