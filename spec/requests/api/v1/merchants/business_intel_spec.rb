require "rails_helper"

describe "All merchants business intelligence" do
  xit "returns x merchants by most revenue" do
    merchant = create(:merchant)
    merchant_2 = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id)
    invoice_2 = create(:invoice, merchant_id: merchant_2.id)
    create(:transaction, invoice_id: invoice.id)
    create(:transaction, invoice_id: invoice_2.id)
    create_list(:transaction, 2, invoice_id: invoice.id, result: "failed")
    invoice_items = create_list(:invoice_item, 3, invoice_id: invoice.id, unit_price: 10, quantity: 3)
    invoice_items_2 = create_list(:invoice_item, 2, invoice_id: invoice_2.id, unit_price: 10, quantity: 1)
    revenue_1 = invoice_items.reduce(0) {|m, ii| m += (ii.unit_price * ii.quantity)}
    revenue_2 = invoice_items_2.reduce(0) {|m, ii| m += (ii.unit_price * ii.quantity)}

    get "/api/v1/merchants/most_revenue?quantity=2"

    expect(response).to be_success

    response_revenue = JSON.parse(response.body)
    binding.pry
    expect(response_revenue.first["revenue"]).to eq(revenue_1)
    expect(response_revenue.last["revenue"]).to eq(revenue_2)
  end

  it "returns merchant revenue by date" do
    merchant = create(:merchant)
    merchant_2 = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id, created_at: "2018-03-14")
    invoice_2 = create(:invoice, merchant_id: merchant_2.id)
    create(:transaction, invoice_id: invoice.id)
    create(:transaction, invoice_id: invoice_2.id)
    create_list(:transaction, 2, invoice_id: invoice.id, result: "failed")
    invoice_items = create_list(:invoice_item, 3, invoice_id: invoice.id)
    invoice_items_2 = create_list(:invoice_item, 2, invoice_id: invoice_2.id)
    revenue = invoice_items.reduce(0) {|m, ii| m += (ii.unit_price * ii.quantity)}/100.0

    get "/api/v1/merchants/revenue?date=#{invoice.created_at}"

    expect(response).to be_success
    response_revenue = JSON.parse(response.body)

    expect(response_revenue).to eq({"total_revenue" => revenue.to_s})
  end

end
