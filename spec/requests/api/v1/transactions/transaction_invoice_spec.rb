require "rails_helper"

describe "transaction invoices controller" do
  it "shows invoice for a specific transaction" do
    invoice = create(:invoice)
    transaction = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    expect(response).to be_success

    result = JSON.parse(response.body)

    expect(result["id"]).to eq(invoice.id)
  end
end
