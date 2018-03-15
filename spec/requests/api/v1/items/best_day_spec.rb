require "rails_helper"

describe "items best day api" do
  it "gets invoice date of for day of an items top revenue" do
    item1 = create(:item)
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    transaction1 = create(:transaction, invoice: invoice1)
    transaction1 = create(:transaction, invoice: invoice2)
    invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 100, created_at: Date.today)
    invoice_item2 = create(:invoice_item, item: item1, invoice: invoice2, quantity: 1)

    get "/api/v1/items/#{item1.id}/best_day"

    results = JSON.parse(response.body)

    expect(response).to be_success
    expect(results).to eq({ "best_day" => JSON.parse(invoice1.created_at.to_json) })
  end
end
