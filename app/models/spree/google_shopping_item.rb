module Spree
  class GoogleShoppingItem < SimpleDelegator
    GOOGLE_SHOPPING_ATTRIBUTES =  %w[
      gs_offer_id
      gs_additional_image_links
      gs_availability
      gs_availability_date
      gs_color
      gs_description
      gs_google_product_category
      gs_identifier_exists
      gs_image_link
      gs_item_group_id
      gs_mpn
      gs_price
      gs_product_type
      gs_shipping_weight
      gs_title
      gs_adult
      gs_adwords_grouping
      gs_adwords_labels
      gs_adwords_redirect
      gs_age_group
      gs_brand
      gs_condition
      gs_gender
      gs_gtin
      gs_bundle
      gs_material
      gs_online_only
      gs_pattern
    ]

    def self.wrap(collection)
      collection.map(&method(:new))
    end
    
    def self.google_shopping_attributes
      GOOGLE_SHOPPING_ATTRIBUTES
    end
    
    def to_request
      GOOGLE_SHOPPING_ATTRIBUTES.map do |attr|
        [attr[/gs_(.+)/, 1].camelize(:lower), self.send(attr)]
      end.to_h.reject { |k,v| v.blank? }
    end
    
    def gs_offer_id
      sku.present? ? sku : id 
    end
  
    def gs_additional_image_links
      images.drop(1).map { |i| i.attachment.url }
    end
    
    def gs_availability
      if in_stock?
        'in stock'
      elsif can_supply?
        'preorder'
      else
        'out of stock'
      end
    end
    
    def gs_availability_date
      product.available_on.try(:iso8601)
    end
    
    def gs_color
      product.product_properties.where(property_id: Spree::Product.color_property_id).pluck(:value).first
    end
    
    def gs_description
      product.description
    end
    
    def gs_google_product_category
      taxon = product.taxons.detect { |t| t.google_shopping_category.present? }
      taxon.try(:google_shopping_category)
    end
    
    def gs_identifier_exists
      gs_gtin.present? && gs_gtin[/^\d{8,13}$/]
    end
    
    def gs_image_link
      (images.any? && images.first.attachment.url) || (product.images.any? && product.images.first.attachment.url)
    end
    
    def gs_item_group_id
      product_id
    end
    
    def gs_link
      product_path(product)
    end
    
    def gs_mpn
      sku
    end
    
    def gs_price
      {
        value: default_price.amount.to_f,
        currency: default_price.currency
      }
    end
    
    def gs_product_type
      product.taxons.map { |t| t.self_and_ancestors.pluck(:name).join(' > ') }.join(', ')
    end
    
    def gs_shipping_weight
      {
        value: [weight.to_i, 1].max,
        unit: Spree::Config.shipping_weight_unit
      }
    end
    
    def gs_title
      product.name
    end
    
    private
    
    def color_option
      @_color_option ||= Rails.cache.fetch(['color_option', Spree::OptionType.maximum(:created_at)]) {
        Spree::OptionType.find_by name: 'Color'
      }
    end    
  end
end
