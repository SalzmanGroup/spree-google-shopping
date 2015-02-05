class AddGoogleShoppingCategoryToSpreeTaxons < ActiveRecord::Migration
  def change
    add_column :spree_taxons, :google_shopping_category, :string
  end
end
