require "rails_helper"

describe "customer random controller" do
  it "gets a random customer" do
    create_list(:customer, 5)
    possible_ids = [1,2,3,4,5]

    get "/api/v1/customers/random.json"

    customer = JSON.parse(response.body)
    expect(response).to be_success
    expect(customer.count).to eq(1)
    expect(possible_ids).to include(customer.first["id"])
  end
end
