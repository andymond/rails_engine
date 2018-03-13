require "rails_helper"

describe "invoice customers contoller" do
  it "returns the associated customer" do
    customer1 = create(:customer)
    customer2 = create(:customer)
    customer3 = create(:customer)
    invoice1 = create(:invoice, customer_id: customer2.id)

    get "/api/v1/invoices/#{invoice1.id}/customer"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result["id"]).to eq(customer2.id)
    expect(result["first_name"]).to eq(customer2.first_name)
  end
end
