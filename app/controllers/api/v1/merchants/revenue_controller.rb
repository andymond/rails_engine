class Api::V1::Merchants::RevenueController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def index
    render json: Invoice.revenue_by_date(revenue_params[:date]), serializer: MerchantRevenueSerializer
  end

  def show
    render json: Merchant.revenue.find(revenue_params[:id]).revenue
  end

  private

    def revenue_params
      params.permit(:id, :date)
    end

end
