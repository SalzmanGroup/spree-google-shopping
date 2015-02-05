Spree::Product.class_eval do
  delegate_belongs_to :master, :gs_adult, :gs_adwords_grouping, :gs_adwords_labels, :gs_adwords_redirect, :gs_age_group, :gs_brand, 
    :gs_color, :gs_condition, :gs_gender, :gs_gtin, :gs_bundle, :gs_material, :gs_online_only, :gs_pattern 
    
end
