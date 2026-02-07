class OrdersController < ApplicationController
  
  def create
    order = Orders::CreateOrder.call(order_params)
    render json: order, status: :created
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def index
    orders = Order.where(customer_id: params[:customer_id])
    render json: orders
  end

  private
  
  def order_params
    params.require(:order).permit(
      :customer_id, :product_name, :quantity, :price, :status
    )
  end
end