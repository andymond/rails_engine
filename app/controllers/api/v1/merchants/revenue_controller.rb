class Api::V1::Merchants::RevenueController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def index
    render json: Invoice.revenue_by_date(revenue_params[:date]), serializer: MerchantRevenueSerializer
  end

  private

  def revenue_params
    params.permit(:date)
  end

end
