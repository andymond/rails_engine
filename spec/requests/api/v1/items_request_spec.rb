require "rails_helper"

describe "Items API" do
  it "shows list of items" do
    create_list(:item, 5)

    get "/api/v1/items.json"

    expect(response).to be_success

    items = JSON.parse(response.body)

    expect(items.count).to eq(5)
  end

  it "can show a single item" do
    item = create(:item)

    get "/api/v1/items/#{item.id}.json"

    expect(response).to be_success

    response_item = JSON.parse(response.body)

    expect(response_item["id"]).to eq(item.id)
  end
end
