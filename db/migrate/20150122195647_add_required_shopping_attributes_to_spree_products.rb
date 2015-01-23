class AddRequiredShoppingAttributesToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :offerId, :string
    add_index :spree_products, :offerId
  end
end
