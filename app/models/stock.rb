class Stock < ApplicationRecord

    # many-to-many association
    has_many :user_stocks
    has_many :users, through: :user_stocks

    validates :name, :ticker, presence:true

    def self.new_lookup_yahoo(ticker_symbol)

        query = BasicYahooFinance::Query.new

        begin
            data = query.quotes(ticker_symbol.upcase)

            short_name = data[ticker_symbol.upcase]['shortName']
            price = data[ticker_symbol.upcase]['regularMarketPrice']['raw']


            return new(ticker: ticker_symbol.upcase, name: short_name, last_price: price)
        rescue => exception
            return nil
        end
        # return client.price(ticker_symbol)
    end

    def self.new_lookup(ticker_symbol)

        client = IEX::Api::Client.new(
            publishable_token: Rails.application.credentials.dig(:iex, :access_key_id),
            secret_token: Rails.application.credentials.dig(:iex, :secret_access_key),
            endpoint: 'https://cloud.iexapis.com/v1')

        begin
            return new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
        rescue => exception
            return nil
        end
        # return client.price(ticker_symbol)
    end

    def self.check_db(ticker_symbol)
        # return Stock.where(ticker: ticker_symbol).first
        # we are already in the model Stock, that's why we dont need Stock at the start.
        return where(ticker: ticker_symbol.upcase).first
    end
end
