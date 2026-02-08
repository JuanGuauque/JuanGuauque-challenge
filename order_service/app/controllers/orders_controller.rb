class OrdersController < ApplicationController
  
  def create
    result = Orders::CreateOrder.call(order_params)
    render json: {
      id: result[:order].id,
      product_name: result[:order].product_name,
      status: result[:order].status,
      customer: {
        id: result[:customer]["id"],
        name: result[:customer]["customer_name"],
        addres: result[:customer]["address"],
        order_count: result[:customer]["orders_count"]
      }
    }, status: :created
  rescue => e
    render json: { error: e.message }, status: :unprocessable_content
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