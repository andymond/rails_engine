class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  default_scope {order(:id)}
  scope :random, -> {order('random()').limit(1)}
end
