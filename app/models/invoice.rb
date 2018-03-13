class Invoice < ApplicationRecord
  belongs_to :merchant, optional: true

  scope :random, -> {order('random()').limit(1)}
end
