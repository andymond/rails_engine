class MerchantRevenueSerializer < ActiveModel::Serializer
  attributes :total_revenue

  def total_revenue
    (object/ 100.0).round(2).to_s
  end
end
