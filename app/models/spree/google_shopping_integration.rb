class Spree::GoogleShoppingIntegration < ActiveRecord::Base
  CHANNELS = %w{online local}
  
  belongs_to :products_scope, polymorphic: true
  
  has_and_belongs_to_many :taxons
  
  validates :name, presence: true
  validates :merchant_id, presence: true
  validates :channel, presence: true, inclusion: { in: CHANNELS }
  validates :content_language, presence: true
  validates :target_country, presence: true
  validates :active, presence: true
  
  scope :active, -> { where(active: true) }
  
  def self.channel_options
    CHANNELS
  end
  
  def products
    scoped_by_taxons(products_scope.try(:products) || Spree::Product.all)
  end
  
  def client
    @_client ||= SpreeGoogleShopping::Client.new(
      params: {
        merchantId: merchant_id,
        dryRun: test?
      }
    )
  end
  
  private
  
  def scoped_by_taxons(products)
    if taxons.any? 
      products.includes(:taxons).where(spree_taxons: { id: taxons })
    else
      products
    end
  end
end
