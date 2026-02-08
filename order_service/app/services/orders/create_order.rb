#Conuslta el cliente y crea la orden devolviendo información de la orden y el cliente
class Orders::CreateOrder
  def self.call(params)
    customer = CustomerServiceClient.fetch(params[:customer_id])
    raise "Customer not found" unless customer

    order = Order.create!(params)

    OrderCreatedPublisher.publish(order)

    { order: order, customer: customer }
  end
end
