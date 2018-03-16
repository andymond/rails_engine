require "rails_helper"

describe "All merchants business intelligence" do
  it "returns x merchants by most revenue" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant_1.id)
    invoice_2 = create(:invoice, merchant_id: merchant_2.id)
    create(:transaction, invoice_id: invoice.id)
    create(:transaction, invoice_id: invoice_2.id)
    create_list(:transaction, 2, invoice_id: invoice.id, result: "failed")
    create_list(:invoice_item, 3, invoice_id: invoice.id, unit_price: 10, quantity: 3)
    create_list(:invoice_item, 2, invoice_id: invoice_2.id, unit_price: 10, quantity: 1)


    get "/api/v1/merchants/most_revenue?quantity=2"

    expect(response).to be_success

    response_revenue = JSON.parse(response.body)

    expect(response_revenue[0]["id"]).to eq(merchant_1.id)
    expect(response_revenue[1]["id"]).to eq(merchant_2.id)
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
    create_list(:invoice_item, 2, invoice_id: invoice_2.id)
    revenue = invoice_items.reduce(0) {|m, ii| m += (ii.unit_price * ii.quantity)}/100.0

    get "/api/v1/merchants/revenue?date=#{invoice.created_at}"

    expect(response).to be_success
    response_revenue = JSON.parse(response.body)

    expect(response_revenue).to eq({"total_revenue" => revenue.to_s})
  end

end
