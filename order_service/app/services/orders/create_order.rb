class Orders::CreateOrder
  def self.call(params)
    customer = CustomerServiceClient.fetch(params[:customer_id])
    raise "Customer not found" unless customer

    order = Order.create!(params)

    OrderCreatedPublisher.publish(order)

    order
  end
end
