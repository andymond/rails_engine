require "rails_helper"

describe "Invoice API" do
  it "shows list of invoices" do
    create_list(:invoice, 6)

    get "/api/v1/invoices"

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(6)
  end
end
