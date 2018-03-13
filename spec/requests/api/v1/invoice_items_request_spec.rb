require "rails_helper"

describe "InvoiceItems API" do
  it "shows list of invoice items" do
    create_list(:invoice_item, 5)

    get "/api/v1/invoice_items"

    expect(response).to be_success

    invoice_items = JSON.parse(response.body)

    expect(invoice_items.count).to eq(5)
  end
end
