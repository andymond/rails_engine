require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  it { should respond_to(:invoice) }
  it { should respond_to(:item) }
end
