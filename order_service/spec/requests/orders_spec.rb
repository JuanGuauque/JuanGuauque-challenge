require "rails_helper"

RSpec.describe "Orders API", type: :request do
  let(:valid_params) do
    {
      order: {
        customer_id: 1,
        product_name: "Laptop",
        quantity: 2,
        price: 2500,
        status: "created"
      }
    }
  end

  before do 
    allow(CustomerServiceClient).to receive(:fetch)
      .and_return({ "id" => 1 })

    allow(OrderCreatedPublisher).to receive(:publish)
  end

  it "creates an order successfully" do
    post "/orders", params: valid_params

    expect(response).to have_http_status(:created)
    expect(Order.count).to eq(1)
  end

  it "returns error when customer is invalid" do
    allow(CustomerServiceClient).to receive(:fetch).and_return(nil)

    post "/orders", params: valid_params

    expect(response).to have_http_status(:unprocessable_content)
  end
end
