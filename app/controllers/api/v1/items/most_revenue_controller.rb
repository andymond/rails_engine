class Api::V1::Items::MostRevenueController < ApplicationController

  def index
    render json: Item.most_revenue(revenue_params[:quantity])
  end

   private

     def revenue_params
       params.permit(:quantity)
     end
end
