class Api::V1::Merchants::FavoriteCustomerController < ApplicationController

  def show
    render json: Customer.most_transactions(params[:id]).first
  end

end
