require "rails_helper"

describe "items most items controller" do
  it "returns the top 1 item instances ranked by total number sold" do
    item1 = create(:item)
    item2 = create(:item)
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    transaction1 = create(:transaction, invoice: invoice1)
    transaction1 = create(:transaction, invoice: invoice2)
    invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 100, created_at: Date.today)
    invoice_item2 = create(:invoice_item, item: item1, invoice: invoice2, quantity: 1)

    get "/api/v1/items/most_items?quantity=1"

    results = JSON.parse(response.body)

    expect(response).to be_success
    expect(results.count).to eq(1)
    expect(results.first["id"]).to eq(item1.id)
  end

  it "returns the top 2 item instances ranked by total number sold" do
    item1 = create(:item)
    item2 = create(:item)
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    transaction1 = create(:transaction, invoice: invoice1)
    transaction2 = create(:transaction, invoice: invoice2)
    invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 100, created_at: Date.today)
    invoice_item2 = create(:invoice_item, item: item2, invoice: invoice2, quantity: 1)

    get "/api/v1/items/most_items?quantity=2"

    results = JSON.parse(response.body)

    expect(response).to be_success
    expect(results.count).to eq(2)
    expect(results.first["id"]).to eq(item1.id)
    expect(results.last["id"]).to eq(item2.id)
  end
end
