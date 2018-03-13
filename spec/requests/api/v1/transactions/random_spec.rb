require "rails_helper"

describe "transaction random controller" do
  it "gets a random transaction" do
    create_list(:transaction, 5)
    possible_ids = [1,2,3,4,5]

    get "/api/v1/transactions/random.json"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction.count).to eq(1)
    expect(possible_ids).to include(transaction.first["id"])
  end
end
