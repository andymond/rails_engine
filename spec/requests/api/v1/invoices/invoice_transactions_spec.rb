require "rails_helper"

describe "invoice transactions controller" do
  it "returns a collection of associated transactions" do
    invoice1 = create(:invoice)
    transaction1 = create(:transaction, invoice_id: 42)
    transaction2 = create(:transaction, invoice_id: invoice1.id)
    transaction3 = create(:transaction, invoice_id: invoice1.id)

    get "/api/v1/invoices/#{invoice1.id}/transactions"

    results = JSON.parse(response.body)

    expect(response).to be_success
    expect(results.count).to eq(2)
    results.each do |transaction|
      expect(transaction["invoice_id"]).to eq(invoice1.id)
    end
  end
end
