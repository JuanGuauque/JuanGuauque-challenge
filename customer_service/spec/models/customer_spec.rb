require 'rails_helper'

RSpec.describe Customer, type: :model do
  it "is valid with valid attributes" do
    customer = Customer.new(
      customer_name: "Juan Guauque",
      address: "Bogotá",
      orders_count: 0
    )

    expect(customer).to be_valid
  end
end
