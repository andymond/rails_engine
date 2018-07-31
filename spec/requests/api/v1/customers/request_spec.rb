require "rails_helper"

describe "customers api" do
  it "sends a list of all customers" do
    create_list(:customer, 3)

    get "/api/v1/customers.json"

    expect(response).to be_success

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(3)
  end
end
