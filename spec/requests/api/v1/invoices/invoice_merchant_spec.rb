require "rails_helper"

describe "invoice merchant controller" do
  it "returns the associated merchant" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    invoice1 = create(:invoice, merchant_id: merchant2.id)

    get "/api/v1/invoices/#{invoice1.id}/merchant"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result["id"]).to eq(merchant2.id)
    expect(result["id"]).to eq(merchant2.id)
    expect(result["name"]).to eq(merchant2.name)
  end
end
