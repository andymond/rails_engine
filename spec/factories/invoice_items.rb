FactoryBot.define do
  factory :invoice_item do
    sequence(:item_id) {|n| n }
    sequence(:invoice_id) {|n| n }
    sequence(:quantity) {|n| n }
    sequence(:unit_price) {|n| n }
  end
end
