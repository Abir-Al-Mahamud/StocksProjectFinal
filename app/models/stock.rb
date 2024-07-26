class Stock < ApplicationRecord
  belongs_to :user
  def fetch_stock_data
    response = HTTParty.get("https://api.example.com/stock/#{symbol}/quote?token=your_api_token")
    JSON.parse(response.body)
  rescue StandardError
    nil
  end
end
