require "rails_helper"

describe "item merchant controller" do
  it "returns the associated merchant" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    item1 = create(:item, merchant_id: merchant2.id)

    get "/api/v1/items/#{item1.id}/merchant"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result["id"]).to eq(merchant2.id)
  end
end
