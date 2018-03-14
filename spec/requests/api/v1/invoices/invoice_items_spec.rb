require "rails_helper"

describe "invoice items controller" do
  it "returns a collection of associated items" do
    invoice1 = create(:invoice)
    item1 = create(:item)
    item2 = create(:item)
    item3 = create(:item)
    invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id)
    invoice_item2 = create(:invoice_item, invoice_id: invoice1.id, item_id: item2.id)
    invoice_item3 = create(:invoice_item, invoice_id: 42, item_id: item3.id)

    get "/api/v1/invoices/#{invoice1.id}/items"

    results = JSON.parse(response.body)

    expect(response).to be_success
    expect(results.count).to eq(2)
    expect(results.first["name"]).to eq(item1.name)
    expect(results.last["name"]).to eq(item2.name)
  end
end
