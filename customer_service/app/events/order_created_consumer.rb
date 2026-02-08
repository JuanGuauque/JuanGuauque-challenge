#Escucha eventos y maneja la logica en este caso incrementa el orders_count
class OrderCreatedConsumer
  QUEUE_NAME = "order.created"

  def self.start
    connection = RABBITMQ_CONNECTION
    connection.start
    
    channel = connection.create_channel
    queue = channel.queue(QUEUE_NAME, durable: true)

    puts "Listening for #{QUEUE_NAME} events.."

    queue.subscribe(block: true) do |_delivery_info, _properties, body|
      payload = JSON.parse(body)
      handle_event(payload)
    end
  end

  def self.handle_event(payload)
    customer_id = payload.dig("payload", "customer_id")
    return unless customer_id

    customer = Customer.find_by(id: customer_id)
    return unless customer

    customer.increment!(:orders_count)
  rescue => e
    Rails.logger.error("Error processing order.created event: #{e.message}")
  end
end
