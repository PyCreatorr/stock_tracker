class User < ApplicationRecord
  # helper_method :self.can_track_stock
  # many-to-many association
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  has_many :friendships
  has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def self.find_friends(search_item)
    begin
      friends = where("first_name ~* :s OR last_name ~* :s OR email ~* :s", {s: search_item })

      return nil if friends.empty?

      # friends = where("first_name ~* :s OR first_name ~* :s OR email ~* :s", {s: search_item})
      return friends

    rescue => exception
        return nil
    end
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  def can_track_friend?(friend_email)
    under_friend_limit? && friend_already_tracked?(friend_email)   
  end

  def under_friend_limit?
    friends.count < 10
  end

  def friend_already_tracked?(friend_email)
    friends.where(email: friend_email).empty?
  end

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
