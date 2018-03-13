require "rails_helper"

describe "customer transactions controller" do
  it "shows transactions for a specific customer" do
    customer = create(:customer)
    customer_invoice = create(:invoice, customer_id: customer.id)
    create(:invoice)
    create_list(:transaction, 4, invoice_id: customer_invoice.id)

    get "/api/v1/customers/#{customer.id}/transactions"

    expect(response).to be_success

    transactions = JSON.parse(response.body)

    transactions.each {|t| expect(t["invoice_id"]).to eq(customer_invoice.id)}
  end
end
