require "rails_helper"

describe "Items with most revenue" do
  it "returns x items based on revenue they generate" do
    item = create(:item)
    invoice = create(:invoice)
    create(:transaction, invoice_id: invoice.id)
    create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice.id, unit_price: 2, quantity: 2)
    item_2 = create(:item)
    invoice_2 = create(:invoice)
    create(:transaction, invoice_id: invoice_2.id)
    create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, unit_price: 1, quantity: 1)
    create_list(:item, 2)

    get "/api/v1/items/most_revenue?quantity=2"

    expect(response).to be_success

    response_revenue = JSON.parse(response.body)

    expect(response_revenue.count).to eq(2)
    expect(response_revenue[0]["id"]).to eq(item.id)
    expect(response_revenue[1]["id"]).to eq(item_2.id)
  end
end
