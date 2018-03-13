require "rails_helper"

describe "Items API" do
  it "shows list of items" do
    create_list(:item, 5)

    get "/api/v1/items"

    expect(response).to be_success

    items = JSON.parse(response.body)

    expect(items.count).to eq(5)
  end
end
