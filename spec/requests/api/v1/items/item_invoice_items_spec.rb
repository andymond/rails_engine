require "rails_helper"

describe "item invoice_items controller" do
  it "returns a collection of associated invoice items" do
    item1 = create(:item)
    invoice_item1 = create(:invoice_item, item_id: item1.id, quantity: 421)
    invoice_item2 = create(:invoice_item, item_id: 42)
    invoice_item3 = create(:invoice_item, item_id: item1.id, quantity: 421)

    get "/api/v1/items/#{item1.id}/invoice_items"

    results = JSON.parse(response.body)

    expect(response).to be_success
    expect(results.count).to eq(2)
    results.each do |invoice_item|
      expect(invoice_item["quantity"]).to eq(421)
    end
  end
end
