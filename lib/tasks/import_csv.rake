require 'csv'

namespace :import_csv do
  task customer: :environment do
    csv_text = File.read("./data/customers.csv")
    csv = CSV.parse(csv_text, headers: :true, header_converters: :symbol, converters: :numeric)
    csv.each do |row|
      Customer.create!(row.to_h)
    end
  end
  task invoice_item: :environment do
    csv_text = File.read("./data/invoice_items.csv")
    csv = CSV.parse(csv_text, headers: :true, header_converters: :symbol, converters: :numeric)
    csv.each do |row|
      InvoiceItem.create!(row.to_h)
    end
  end
  task invoice: :environment do
    csv_text = File.read("./data/invoices.csv")
    csv = CSV.parse(csv_text, headers: :true, header_converters: :symbol, converters: :numeric)
    csv.each do |row|
      Invoice.create!(row.to_h)
    end
  end
  task merchant: :environment do
    csv_text = File.read("./data/merchants.csv")
    csv = CSV.parse(csv_text, headers: :true, header_converters: :symbol, converters: :numeric)
    csv.each do |row|
      Merchant.create!(row.to_h)
    end
  end
  task transaction: :environment do
    csv_text = File.read("./data/transactions.csv")
    csv = CSV.parse(csv_text, headers: :true, header_converters: :symbol, converters: :numeric)
    csv.each do |row|
      Transaction.create!(row.to_h)
    end
  end
  task item: :environment do
    csv_text = File.read("./data/items.csv")
    csv = CSV.parse(csv_text, headers: :true, header_converters: :symbol, converters: :numeric)
    csv.each do |row|
      Item.create!(row.to_h)
    end
  end

  task all: ["customer", "invoice_item" ,"invoice", "merchant", "transaction", "item"]
end



# rake import_csv:customer
# rake import_csv or rake import_csv:*
