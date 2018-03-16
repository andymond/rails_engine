require "rails_helper"

describe "Customers with pending invoices for a merchant" do
  it "returns all customers with invoices with no successful transactions" do
    merchant   = create(:merchant)
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    invoice_1  = create(:invoice, merchant_id: merchant.id, customer_id: customer_1.id)
    invoice_2  = create(:invoice, merchant_id: merchant.id, customer_id: customer_2.id)
    create(:transaction, invoice_id: invoice_1.id)
    create_list(:transaction, 3, invoice_id: invoice_2.id, result: "failed")

    get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

    expect(response).to be_success

    response_customers = JSON.parse(response.body)
    
    expect(response_customers.count).to eq(1)
    expect(response_customers[0]["id"]).to eq(customer_2.id)
  end
end
