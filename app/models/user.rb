class User < ApplicationRecord
  # helper_method :self.can_track_stock
  # many-to-many association
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def full_name
    return "#{first_name} #{last_name}" if (first_name.present? || last_name.present?)
    return "Anonymos"
  end

  def stock_already_tracked?(ticker_symbol)
    # check if the stock exists in the Stock table
    stock = Stock.check_db(ticker_symbol)
    return false unless stock 
    #return false, unless stock is empty
    stocks.where(id: stock.id).exists?

    # stocks.where(ticker: ticker_symbol.upcase).exists?
    # stocks.where(ticker: ticker_symbol).blank?
  end
  
  def under_stock_limit?
    stocks.count < 10
  end

  def can_track_stock?(ticker_symbol)
    # if User.stocks.count < 10
    # User.stocks.where(ticker: stock.ticker.upcase)
    # UserStock.create(user: current_user, stock: stock) 

    # return true if the under_stock_limit? && !stock_already_tracked?
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end
end
