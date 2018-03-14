class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: Invoice.revenue_by_date(revenue_params[:date])
  end

  private

  def revenue_params
    params.permit(:date)
  end

end
