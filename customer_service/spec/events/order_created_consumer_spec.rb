require "rails_helper"

RSpec.describe OrderCreatedConsumer do
  let!(:customer) do
    Customer.create!(
      customer_name: "Juan Guauque",
      address: "Bogotá",
      orders_count: 0
    )
  end

  let(:payload) do
    {
      "event" => "order.created",
      "payload" => {
        "order_id" => 1,
        "customer_id" => customer.id
      }
    }
  end

  it "increments orders_count when event is processed" do
    expect {
      described_class.handle_event(payload)
  }.to change { customer.reload.orders_count }.by(1)
  end

  it "does nothing when customer doesn't exist" do
    payload["payload"]["customer_id"] = 999

    expect {
      described_class.handle_event(payload)
  }.not_to raise_error
  end
end