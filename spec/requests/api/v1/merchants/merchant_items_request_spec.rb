require "rails_helper"

describe "merchants items controller" do
  it "displays items for a specific merchant" do
    merchant = create(:merchant)
    create_list(:item, 4, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_success

    items = JSON.parse(response.body)

    items.each {|i| expect(i.merchant_id).to eq(merchant.id)}
  end
end
