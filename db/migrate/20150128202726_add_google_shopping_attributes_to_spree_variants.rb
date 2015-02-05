class AddGoogleShoppingAttributesToSpreeVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :gs_adult, :boolean
    add_column :spree_variants, :gs_adwords_grouping, :string
    add_column :spree_variants, :gs_adwords_labels, :string
    add_column :spree_variants, :gs_adwords_redirect, :string
    add_column :spree_variants, :gs_age_group, :string
    add_column :spree_variants, :gs_brand, :string
    add_column :spree_variants, :gs_condition, :string
    add_column :spree_variants, :gs_gender, :string
    add_column :spree_variants, :gs_gtin, :string
    add_column :spree_variants, :gs_bundle, :boolean
    add_column :spree_variants, :gs_material, :string
    add_column :spree_variants, :gs_online_only, :boolean
    add_column :spree_variants, :gs_pattern, :string
  end
end
