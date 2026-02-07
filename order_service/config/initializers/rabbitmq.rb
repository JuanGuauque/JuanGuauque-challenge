require 'bunny'

RABBITMQ_CONNECTION = Bunny.new(
  host: ENV.fetch("RABBITMQ_HOST", "localhost"),
  username: ENV.fetch("RABBITMQ_USER", "guest"),
  password: ENV.fetch("RABBITMQ_PASSWORD", "guest")
)
