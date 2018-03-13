FactoryBot.define do
  factory :transaction do
    sequence(:invoice_id) { |n| n }
    sequence(:credit_card_number) { |n| n }
    sequence(:credit_card_expiration_date) { |n| n }
    result "success"
  end
end
