class Api::V1::Merchants::RandomController < ApplicationController

  def show
    render json: Merchant.order('random()').limit(1)
  end
end
