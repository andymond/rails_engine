require "rails_helper"

describe "Invoice API" do
  it "shows list of invoices" do
    create_list(:invoice, 6)

    get "/api/v1/invoices"

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(6)
  end

  it "shows a single invoice" do
    invoice = create(:invoice)

    get "/api/v1/invoices/#{invoice.id}.json"

    expect(response).to be_success

    response_invoice = JSON.parse(response.body)

    expect(response_invoice["id"]).to eq(invoice.id)
  end

  it "can find one invoice with matching attribute" do
     create(:invoice, status: "success")

     get "/api/v1/invoices/find?status=success"

     expect(response).to be_success

     invoice = JSON.parse(response.body)

     expect(invoice["status"]).to eq("success")
  end

  it "can find all invoice items with matching attribute" do
     create_list(:invoice, 4, status: "success")

     get "/api/v1/invoices/find_all?status=success"

     expect(response).to be_success

     invoices = JSON.parse(response.body)

     invoices.each {|i| expect(i["status"]).to eq("success")}
  end
end
