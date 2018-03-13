require "rails_helper"

describe "transaction search controller" do
  it "gets one transaction by any param given" do
    transaction1 = create(:transaction,
                           invoice_id: 420,
                           credit_card_number: 840,
                           credit_card_expiration_date: 240,
                           result: "whatever")
    create_list(:transaction, 2)

    get "/api/v1/transactions/find?invoice_id=420"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["id"]).to eq(transaction1.id)

    get "/api/v1/transactions/find?credit_card_number=840"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["id"]).to eq(transaction1.id)

    get "/api/v1/transactions/find?credit_card_expiration_date=240"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["id"]).to eq(transaction1.id)

    get "/api/v1/transactions/find?result=whatever"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["id"]).to eq(transaction1.id)
  end

  it "gets all transactions based on given params" do
    transaction1 = create(:transaction,
                           invoice_id: 420,
                           credit_card_number: 123,
                           credit_card_expiration_date: 240,
                           result: "whatever")
    transaction2 = create(:transaction,
                           invoice_id: 420,
                           credit_card_number: 840,
                           credit_card_expiration_date: 240,
                           result: "ehh")
    transaction3 = create(:transaction,
                           invoice_id: 123,
                           credit_card_number: 840,
                           credit_card_expiration_date: 240,
                           result: "ok")
    transaction4 = create(:transaction,
                           invoice_id: 234,
                           credit_card_number: 840,
                           credit_card_expiration_date: 240,
                           result: "ok")

    get "/api/v1/transactions/find_all?invoice_id=420"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(2)
    transactions.each do |transaction|
      expect(transaction["invoice_id"]).to eq(420)
    end

    get "/api/v1/transactions/find_all?credit_card_number=840"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(3)
    transactions.each do |transaction|
      expect(transaction["credit_card_number"]).to eq(840)
    end

    get "/api/v1/transactions/find_all?credit_card_expiration_date=240"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(4)
    transactions.each do |transaction|
      expect(transaction["credit_card_expiration_date"]).to eq(240)
    end

    get "/api/v1/transactions/find_all?result=ok"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(2)
    transactions.each do |transaction|
      expect(transaction["result"]).to eq("ok")
    end
  end
end
