class Api::V1::Customers::FavoriteMerchantController < ApplicationController

  def show
    render json: Merchant.favorite_merchant(favorite_merchant_params[:id]).first
  end

  private

    def favorite_merchant_params
      params.permit(:id)
    end
end
