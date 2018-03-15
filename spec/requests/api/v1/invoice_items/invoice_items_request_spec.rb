require "rails_helper"

describe "InvoiceItems API" do
  it "shows list of invoice items" do
    create_list(:invoice_item, 5)

    get "/api/v1/invoice_items.json"

    expect(response).to be_success

    invoice_items = JSON.parse(response.body)

    expect(invoice_items.count).to eq(5)
  end

  it "can show a single invoice item" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/#{invoice_item.id}.json"

    expect(response).to be_success

    response_invoice_item = JSON.parse(response.body)

    expect(response_invoice_item["id"]).to eq(invoice_item.id)
  end

  it "can find one invoice item with matching attribute" do
    create(:invoice_item, invoice_id: 2)

    get "/api/v1/invoice_items/find?invoice_id=2"

    expect(response).to be_success

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["invoice_id"]).to eq(2)
  end

  it "can find item by unit_price" do
    item = create(:invoice_item, unit_price: 1000)

    get "/api/v1/invoice_items/find?unit_price=10.00"

    expect(response).to be_success

    response_invoice_item = JSON.parse(response.body)

    expect(response_invoice_item["id"]).to eq(item.id)
  end

  it "can find all invoice items with matching attributes" do
    create_list(:invoice_item, 3, item_id: 1)

    get "/api/v1/invoice_items/find_all?item_id=1"

    expect(response).to be_success

    invoice_items = JSON.parse(response.body)

    invoice_items.each {|i_i| expect(i_i["item_id"]).to eq(1)}
  end

  it "shows a random invoice_item" do
    create_list(:invoice_item, 4)
    possible_ids = [1, 2, 3, 4]

    get "/api/v1/invoice_items/random.json"

    invoice = JSON.parse(response.body)

    expect(possible_ids).to include(invoice[0]["id"])
    expect(invoice[0]["item_id"]).to_not eq(nil)
    expect(invoice[0]["invoice_id"]).to_not eq(nil)
    expect(invoice[0]["quantity"]).to_not eq(nil)
    expect(invoice[0]["unit_price"]).to_not eq(nil)
  end
end
