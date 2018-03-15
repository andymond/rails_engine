require "rails_helper"

describe "merchants top by items sold controller" do
  it "returns the top x merchants ranked by total number of items sold" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    invoice1 = create(:invoice, merchant: merchant1)
    invoice2 = create(:invoice, merchant: merchant2)
    invoice3 = create(:invoice, merchant: merchant1)
    invoice_item1 = create(:invoice_item, invoice: invoice1)
    invoice_item2 = create(:invoice_item, invoice: invoice2)
    invoice_item3 = create(:invoice_item, invoice: invoice1)
    transaction1 = create(:transaction, invoice: invoice1)
    transaction2 = create(:transaction, invoice: invoice2)
    transaction3 = create(:transaction, invoice: invoice1)

    get "/api/v1/merchants/most_items?quantity=1"

    results = JSON.parse(response.body)
    expect(response).to be_success
    expect(results.count).to eq(1)
    expect(results.first["id"]).to eq(merchant1.id)

    get "/api/v1/merchants/most_items?quantity=2"

    results = JSON.parse(response.body)
    expect(response).to be_success
    expect(results.count).to eq(2)
    expect(results.first["id"]).to eq(merchant1.id)
    expect(results.last["id"]).to eq(merchant2.id)
  end
end
