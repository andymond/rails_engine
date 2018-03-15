class Api::V1::Merchants::MostRevenueController < ApplicationController

  def index
    render json: Merchant.revenue.limit(revenue_params[:quantity])
  end

  private

    def revenue_params
      unless params[:quantity].nil?
        params[:quantity] = params[:quantity].to_i
      end
      params.permit(:quantity)
    end
end
