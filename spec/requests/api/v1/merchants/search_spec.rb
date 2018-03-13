require "rails_helper"

describe "merchants search controller" do
  it "gets a merchant based on any param given" do
    merchant1 = create(:merchant, name: "merchant1")
    create(:merchant, name: "merchant2")
    create(:merchant, name: "merchant3")

    get "/api/v1/merchants/find?name=merchant1"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant1["name"]).to eq("merchant1")
  end

  it "gets all merchants matching request params" do
    create(:merchant, name: "merchant1")
    create(:merchant, name: "merchant1")
    create(:merchant, name: "merchant2")

    get "/api/v1/merchants/find_all?name=merchant1"

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(2)
  end
end
