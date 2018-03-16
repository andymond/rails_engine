class Api::V1::Merchants::RevenueController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def index
    render json: Invoice.revenue_by_date(revenue_params[:date]), serializer: MerchantRevenueSerializer
  end

  def show
    if !revenue_params[:date].nil?
      render json: Invoice.single_merchant_revenue_by_date(revenue_params[:date], revenue_params[:id]), serializer: SingleMerchantRevenueDateSerializer
    else
      render json: Merchant.revenue.find(revenue_params[:id]).revenue, serializer: SingleMerchantRevenueSerializer
    end
  end

  private

    def revenue_params
      params.permit(:id, :date)
    end

end
