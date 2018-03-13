require "rails_helper"

describe "merchants invoices controller" do
  it "displays invoices for a specific merchant" do
    merchant = create(:merchant)
    merchant_2 = create(:merchant)
    create(:invoice, merchant_id: merchant_2.id)
    create_list(:invoice, 4, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    expect(response).to be_success

    items = JSON.parse(response.body)

    items.each {|i| expect(i["merchant_id"]).to eq(merchant.id)}
  end
end
