FactoryGirl.define do
  factory :google_shopping_integration, class: Spree::GoogleShoppingIntegration do
    name { Faker::Lorem.word }
    merchant_id { rand.to_s[2..7] }
    channel 'online'
    content_language 'en'
    target_country 'us'
    active true
  end
end
