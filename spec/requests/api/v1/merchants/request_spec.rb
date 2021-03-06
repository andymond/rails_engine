require "rails_helper"

describe "merchants controller" do
  it "sends a list of merchants" do
      create_list(:merchant, 3)

      get "/api/v1/merchants.json"

      expect(response).to be_success

      merchants = JSON.parse(response.body)

      expect(merchants.count).to eq(3)
  end

  it "can get one merchant by id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}.json"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(id)
  end
end
