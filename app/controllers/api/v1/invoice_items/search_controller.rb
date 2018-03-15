class Api::V1::InvoiceItems::SearchController < ApplicationController

  def show
    render json: InvoiceItem.find_by(invoice_item_params)
  end

  def index
    render json: InvoiceItem.where(invoice_item_params)
  end

  private

  def invoice_item_params
    unless params[:unit_price].nil?
      params[:unit_price] = params[:unit_price].to_f * 100
    end
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end

end
