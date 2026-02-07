require 'rails_helper'

RSpec.describe Orders::CreateOrder do
  let(:params) do
    {
      customer_id: 1,
      product_name: "Laptop",
      quantity: 2,
      price: 2500,
      status: "created"
    }
  end

  before do
    allow(CustomerServiceClient).to receive(:fetch)
      .with(1)
      .and_return({ "id" => 1, "customer_name" => "Juan" })

    allow(OrderCreatedPublisher).to receive(:publish)
  end

  it "creates an order when customer exists" do
    expect {
      described_class.call(params)
    }.to change(Order, :count).by(1)
  end

  it "publishes order created event" do
    order = described_class.call(params)
    expect(OrderCreatedPublisher).to have_received(:publish).with(order)
  end

  it "raises error when customer doesn't exist" do
    allow(CustomerServiceClient).to receive(:fetch).and_return(nil)

    expect {
      described_class.call(params)
    }.to raise_error("Customer not found")
  end
end
