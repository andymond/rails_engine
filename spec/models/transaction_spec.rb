require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { should respond_to(:invoice) }
end
