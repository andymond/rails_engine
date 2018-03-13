FactoryBot.define do
  factory :item do
    sequence(:name) {|n| "item#{n}"}
    sequence(:description) {|n| "description#{n}"}
    sequence(:unit_price) {|n| n}
    sequence(:merchant_id) {|n| n}
  end
end
