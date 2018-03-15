class SingleMerchantRevenueSerializer < ActiveModel::Serializer
  attributes :revenue

  def revenue
    (object / 100.0).round(2).to_s
  end
end
