require "rails_helper"

describe "customer invoices controller" do
  it "shows invoices for a specific customer" do
    customer = create(:customer)
    create_list(:invoice, 4, customer_id: customer.id)
    create(:invoice)

    get "/api/v1/customers/#{customer.id}/invoices"

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    invoices.each {|i| expect(i["customer_id"]).to eq(customer.id)}
  end
end
