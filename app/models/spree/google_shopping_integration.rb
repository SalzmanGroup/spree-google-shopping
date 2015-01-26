class Spree::GoogleShoppingIntegration < ActiveRecord::Base
  CHANNELS = %w{online local}
  
  belongs_to :products_scope, polymorphic: true
  
  validates :name, presence: true
  validates :merchant_id, presence: true
  validates :channel, presence: true, inclusion: { in: CHANNELS }
  validates :content_language, presence: true
  validates :target_country, presence: true
  validates :active, presence: true
  
  def self.channel_options
    CHANNELS
  end
  
  def products
    products_scope.try(:products) || Spree::Product.all
  end
end
