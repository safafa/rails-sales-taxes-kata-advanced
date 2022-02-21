FactoryBot.define do
  factory :entry, class: 'Entry' do
    quantity { '1' }
    basic_tax { '0' }
    import_tax { '0' }
    final_price { '0' }
    association :basket

    trait :exempt do
      name { 'chocolate' }
      price { '10.00' }
    end

    trait :imported do
      name { 'imported bottle of perfume' }
      price { '47.50' }
    end

    trait :imported_exempt do
      name { 'imported box of chocolates' }
      price { '10.00' }
    end

    factory :exempt, traits: [:exempt]
    factory :imported, traits: [:imported]
    factory :imported_exempt, traits: [:imported_exempt]
  end
end
