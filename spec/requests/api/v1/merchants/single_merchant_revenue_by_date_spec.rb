require "rails_helper"

describe "single merchant revenue by date" do
  it "returns the total revenue for that merchant for a specific invoice date x" do
    merchant1 = create(:merchant)
    invoice1 = create(:invoice, merchant: merchant1)
    invoice_item1 = create(:invoice_item, invoice: invoice1)
    transaction1 = create(:transaction, invoice: invoice1)

    get "/api/v1/merchants/#{merchant1.id}/revenue?date=#{invoice1.created_at}"

    results = JSON.parse(response.body)
    merchant_revenue = (Merchant.revenue.find(merchant1.id).revenue) / 100.00

    expect(response).to be_success
    expect(results).to eq({ "revenue" => "#{merchant_revenue}" })
  end
end
