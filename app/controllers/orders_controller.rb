class OrdersController < ApplicationController
  def index
  end

  def fulfill
    @order = Order.find(params[:id])
    if @order.update(fulfilled: true)
      render json: @order, status: :ok
    else
      render json: {error: "Failed to fulfill order"}, status: :unprocessable_entity
    end
  end
end
