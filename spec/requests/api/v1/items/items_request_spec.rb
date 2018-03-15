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

  it "can find item by attribute" do
    item = create(:item)

    get "/api/v1/items/find?name=#{item.name}"

    expect(response).to be_success

    response_item = JSON.parse(response.body)

    expect(response_item["id"]).to eq(item.id)
  end

  it "can find item by unit_price" do
    item = create(:item, unit_price: 1000)

    get "/api/v1/items/find?unit_price=10.00"

    expect(response).to be_success

    response_item = JSON.parse(response.body)

    expect(response_item["id"]).to eq(item.id)
  end

  it "can find all items with matching attributes" do
    item = create(:item, name: "gold")
    item_2 = create(:item, name: "gold")

    get "/api/v1/items/find_all?name=#{item.name}"

    expect(response).to be_success

    response_items = JSON.parse(response.body)

    expect(response_items.first["name"]).to eq("gold")
    expect(response_items.last["name"]).to eq("gold")
  end

  it "shows a random item" do
    create_list(:item, 4)
    possible_ids = [1, 2, 3, 4]

    get "/api/v1/items/random.json"

    invoice = JSON.parse(response.body)

    expect(possible_ids).to include(invoice[0]["id"])
    expect(invoice[0]["name"]).to_not eq(nil)
    expect(invoice[0]["description"]).to_not eq(nil)
    expect(invoice[0]["merchant_id"]).to_not eq(nil)
  end
end
