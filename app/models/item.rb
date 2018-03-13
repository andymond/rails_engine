class Item < ApplicationRecord
  scope :random, -> {order('random()').limit(1)}
end
