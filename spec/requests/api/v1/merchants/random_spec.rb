require "rails_helper"

describe "merchanta random controller" do
  it "gets random merchant" do
    create_list(:merchant, 5)

    get "/api/v1/merchants/random.json"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant.first["name"]).to include("merchant")
  end
end
