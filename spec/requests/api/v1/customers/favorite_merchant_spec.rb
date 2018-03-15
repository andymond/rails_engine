require "rails_helper"

describe "customers favorite merchant controller" do
  it "returns a merchant where the customer has conducted the most successful transactions" do
    customer1 = create(:customer)
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    invoice1 = create(:invoice, customer: customer1, merchant: merchant1)
    invoice1 = create(:invoice, customer: customer1, merchant: merchant2)
    invoice1 = create(:invoice, customer: customer1, merchant: merchant1)

    get "/api/v1/customers/#{customer1.id}/favorite_merchant"

    results = JSON.parse(response.body)

    expect(response).to be_success
  end
end
