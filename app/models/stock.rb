class Stock < ApplicationRecord


    def self.new_lookup(ticker_symbol)

        client = IEX::Api::Client.new(
            publishable_token: Rails.application.credentials.dig(:iex, :access_key_id),
            secret_token: Rails.application.credentials.dig(:iex, :secret_access_key),
            endpoint: 'https://cloud.iexapis.com/v1')
    
        return client.price(ticker_symbol)
        end
end
