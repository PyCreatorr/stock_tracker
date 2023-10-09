class UserStocksController < ApplicationController

    def create

        # Check if the stock is already in the db stocks
        stock = Stock.check_db(params[:ticker])
        if stock.blank?
            stock = Stock.new_lookup_yahoo(params[:ticker])
            stock.save
        end

        # Check if the user already tracks this stock
        # user_stock_record = UserStock.where(user_id: current_user.id, stock_id: stock.id)
        user_stock_record = UserStock.where(user: current_user, stock: stock).first
        if user_stock_record.blank?
            @user_stock = UserStock.create(user: current_user, stock: stock)            
        end
            
        flash[:notice] = "The Stock #{stock.name} was successfully added to your data!"
        redirect_to my_data_path
    end
end
