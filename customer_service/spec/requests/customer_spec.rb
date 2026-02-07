require 'rails_helper'

RSpec.describe "Customers API", type: :request do

  let!(:customer) do
    Customer.create!(
      customer_name: "Juan Guauque",
      address: "Bogotá",
      orders_count: 2
    )
  end

  it "returns customer details" do
    get "/customers/#{customer.id}"

    expect(response).to have_http_status(:ok)

    json = JSON.parse(response.body)
    expect(json["customer_name"]).to eq("Juan Guauque")
    expect(json["address"]).to eq("Bogotá")
    expect(json["orders_count"]).to eq(2)
  end

  it "returns error 404 when customer doesn't exist" do
    get "/customer/99999"

    expect(response).to have_http_status(:not_found)
  end

end
