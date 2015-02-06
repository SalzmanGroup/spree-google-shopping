Spree::Preferences::Configuration.class_eval do
  preference :shipping_weight_unit, :string, default: 'lbs'
  preference :google_shopping_batch_size, :integer, default: 100
end
