require "rails_helper"

describe "Single merchant business intelligence" do
  it "returns total revenue for merchant accross successful transactions" do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id)
    create(:transaction, invoice_id: invoice.id)
    create_list(:transaction, 2, invoice_id: invoice.id, result: "failed")
    invoice_items = create_list(:invoice_item, 3, invoice_id: invoice.id)
    revenue = invoice_items.reduce(0) {|m, ii| m += (ii.unit_price * ii.quantity)}

    get "/api/v1/merchants/#{merchant.id}/revenue"

    expect(response).to be_success

    response_revenue = JSON.parse(response.body)

    expect(response_revenue[""]).to eq(revenue)
  end
end
