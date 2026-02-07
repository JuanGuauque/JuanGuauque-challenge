class OrderCreatedPublisher
  QUEUE_NAME = "order.created"

  def self.publish(order)
    connection = RABBITMQ_CONNECTION
    connection.start

    channel = connection.channel
    queue = channel.queue(QUEUE_NAME, durable: true)

    event = {
      event: "order.created",
      payload: {
        order_id: order.id,
        customer_id: order.customer_id
      }
    }

    queue.publish(event.to_json, persistent: true)
  end
end
