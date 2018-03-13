require "rails_helper"

describe "Invoice API" do
  it "shows list of invoices" do
    create_list(:invoice, 6)

    get "/api/v1/invoices"

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(6)
  end

  it "shows a single invoice" do
    invoice = create(:invoice)

    get "/api/v1/invoices/#{invoice.id}.json"

    expect(response).to be_success

    response_invoice = JSON.parse(response.body)

    expect(response_invoice["id"]).to eq(invoice.id)
  end
end
