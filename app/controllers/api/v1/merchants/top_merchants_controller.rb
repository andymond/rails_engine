class Api::V1::Merchants::TopMerchantsController < ApplicationController

  def index
    render json: Merchant.top_merchants_by_items_sold(top_merchants_params["quantity"])
  end

  private

    def top_merchants_params
      params.permit(:quantity)
    end
end
