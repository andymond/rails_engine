require "rails_helper"

describe "invoice invoice_items controller" do
  it "returns a collection of associated invoice items" do
    invoice1 = create(:invoice)
    invoice_item1 = create(:invoice_item, invoice_id: 42)
    invoice_item2 = create(:invoice_item, invoice_id: invoice1.id)
    invoice_item3 = create(:invoice_item, invoice_id: invoice1.id)

    get "/api/v1/invoices/#{invoice1.id}/invoice_items"

    results = JSON.parse(response.body)

    expect(response).to be_success
    expect(results.count).to eq(2)
    results.each do |invoice_item|
      expect(invoice_item["invoice_id"]).to eq(invoice1.id)
    end
  end
end
