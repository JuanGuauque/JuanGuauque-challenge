require 'rails_helper'

RSpec.describe Order, type: :model do
  it "is valid with valid attributes" do
    order = Order.new(
      customer_id: 1,
      product_name: "Laptop",
      quantity: 2,
      price: 2500,
      status: "created"
    )

    expect(order).to be_valid
  end
end
