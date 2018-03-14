require "rails_helper"

describe "invoice_items invoice controller" do
  it "returns the associated invoice" do
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    invoice3 = create(:invoice)
    invoice_item1 = create(:invoice_item, invoice_id: invoice2.id)

    get "/api/v1/invoice_items/#{invoice_item1.id}/invoice"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result["id"]).to eq(invoice_item1.invoice_id)
  end
end
