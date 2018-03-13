require "rails_helper"

describe "customer search controller" do
  it "gets one customer by any param given" do
    customer1 = create(:customer,
                        first_name: "patrick",
                        last_name: "bateman")
    create_list(:customer, 4)

    get "/api/v1/customers/find?first_name=patrick"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer["first_name"]).to eq("patrick")

    get "/api/v1/customers/find?last_name=bateman"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer["last_name"]).to eq("bateman")
  end

  it "gets all customers by params given" do
    customer1 = create(:customer,
                        first_name: "patrick",
                        last_name: "bateman")
    customer2 = create(:customer,
                        first_name: "patrick",
                        last_name: "allen")
    customer3 = create(:customer,
                        first_name: "paul",
                        last_name: "allen")

    get "/api/v1/customers/find_all?first_name=paTRick"

    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(customers.count).to eq(2)
    customers.each do |customer|
      expect(customer["first_name"]).to eq("patrick")
    end

    get "/api/v1/customers/find_all?last_name=aLLen"

    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(customers.count).to eq(2)
    customers.each do |customer|
      expect(customer["last_name"]).to eq("allen")
    end
  end
end
