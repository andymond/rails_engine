require "rails_helper"

describe "merchant revenue controller" do
  it "returns the total revenue for that merchant across successful transactions" do
    merchant1 = create(:merchant)
    invoice1 = create(:invoice, merchant: merchant1)
    invoice2 = create(:invoice, merchant: merchant1)
    invoice_item1 = create(:invoice_item, invoice: invoice1)
    invoice_item2 = create(:invoice_item, invoice: invoice2)
    invoice_item3 = create(:invoice_item, invoice: invoice1)
    transaction1 = create(:transaction, invoice: invoice1)
    transaction2 = create(:transaction, invoice: invoice2)

    get "/api/v1/merchants/#{merchant1.id}/revenue"

    results = JSON.parse(response.body)

    merchant_revenue = (Merchant.revenue.find(merchant1.id).revenue) / 100.00

    expect(response).to be_success
    expect(results).to eq({ "revenue" => "#{merchant_revenue}" })
  end
end
