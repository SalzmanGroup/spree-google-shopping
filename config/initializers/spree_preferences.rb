Spree::Preferences::Configuration.class_eval do
  preference :shipping_weight_unit, :string, default: 'lbs'
end
