require "rails_helper"

describe "Items with most revenue" do
  it "returns x items based on revenue they generate" do
    item = create(:item)
    invoice = create(:invoice)
    create(:transaction, invoice_id: invoice_1.id)
    invoice_items = create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice.id)
    revenue = invoice_items.reduce(0) {|m, ii| m += (ii.unit_price * ii.quantity)}

    get "/api/v1/items/most_revenue?quantity=2"

    expect(response).to be_success

    response_revenue = JSON.parse(response.body)

    expect(response_revenue["revenue"]).to eq(revenue)
  end
end
