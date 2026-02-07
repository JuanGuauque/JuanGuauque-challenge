class CustomerServiceClient
  include HTTParty
  base_uri ENV.fetch("CUSTOMER_SERVICE_URL", "http://localhost:3001")

  def self.fetch(customer_id)
    response = get("/customers/#{customer_id}")
    response.success? ? response.parsed_response : nil
  end
end
