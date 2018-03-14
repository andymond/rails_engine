require "rails_helper"

describe "invoice_items item controller" do
  it "returns the associated item" do
    item1 = create(:item)
    item2 = create(:item)
    item3 = create(:item)
    invoice_item1 = create(:invoice_item, item_id: item2.id)

    get "/api/v1/invoice_items/#{invoice_item1.id}/item"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result["id"]).to eq(invoice_item1.item_id)
  end
end
