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
    invoice_item = create(:invoice_item, invoice_id: 2)

    get "/api/v1/invoice_items/find?invoice_id=2"

    expect(response).to be_success

    response_invoice_item = JSON.parse(response.body)

    expect(response_invoice_item["invoice_id"]).to eq(2)
  end

  it "can find all invoice items with matching attributes" do
    create_list(:invoice_item, 3, item_id: 1)

    get "/api/v1/invoice_items/find_all?item_id=1"

    expect(response).to be_success

    invoice_items = JSON.parse(response.body)

    invoice_items.each {|i_i| expect(i_i["item_id"]).to eq(1)}
  end
end
