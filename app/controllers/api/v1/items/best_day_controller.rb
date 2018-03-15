class Api::V1::Items::BestDayController < ApplicationController

  def show
    render json: Invoice.dates(item_best_day_params[:id]), serializer: ItembestdaySerializer
  end

  private

    def item_best_day_params
      params.permit(:id)
    end
end
