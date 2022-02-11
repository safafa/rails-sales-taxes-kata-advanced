FactoryBot.define do
  factory :basket, class: 'Basket' do
    sales_taxes { '0' }
    total { '0' }
    association :user
  end
end
