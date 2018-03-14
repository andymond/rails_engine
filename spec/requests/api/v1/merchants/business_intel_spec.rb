require "rails_helper"

describe "All merchants business intelligence" do
  it "returns x merchants by most revenue" do
    merchant = create(:merchant)
    merchant_2 = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id)
    invoice_2 = create(:invoice, merchant_id: merchant_2.id)
    create(:transaction, invoice_id: invoice.id)
    create(:transaction, invoice_id: invoice_2.id)
    create_list(:transaction, 2, invoice_id: invoice.id, result: "failed")
    invoice_items = create_list(:invoice_item, 3, invoice_id: invoice.id)
    invoice_items_2 = create_list(:invoice_item, 2, invoice_id: invoice_2.id)
    revenue_1 = invoice_items.reduce(0) {|m, ii| m += (ii.unit_price * ii.quantity)}
    revenue_2 = invoice_items_2.reduce(0) {|m, ii| m += (ii.unit_price * ii.quantity)}

    get "/api/v1/merchants/most_revenue?quantity=2"

    expect(response).to be_success

    response_revenue = JSON.parse(response.body)

    expect(response_revenue.first["revenue"]).to eq(revenue_1)
    expect(response_revenue.last["revenue"]).to eq(revenue_2)
  end
end
