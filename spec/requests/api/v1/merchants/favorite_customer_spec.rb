require "rails_helper"

describe "Merchant's favorite customer" do
  it "returns the customer with the most transactions for a merchant" do
    merchant = create(:merchant)
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    invoice_1 = create(:invoice, merchant_id: merchant.id, customer_id: customer_1.id)
    invoice_2 = create(:invoice, merchant_id: merchant.id, customer_id: customer_2.id)
    invoice_1.transactions.create(result: "success")
    invoice_1.transactions.create(result: "success")
    invoice_1.transactions.create(result: "success")
    invoice_2.transactions.create(result: "success")

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    expect(response).to be_success

    response_customer = JSON.parse(response.body)

    expect(response_customer[0]["id"]).to eq(customer_1.id)
  end
end
