class Invoice < ApplicationRecord
  belongs_to :merchant, optional: true
  has_many :transactions

  scope :random, -> {order('random()').limit(1)}
end
