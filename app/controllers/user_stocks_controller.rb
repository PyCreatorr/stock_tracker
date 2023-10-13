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

    def destroy 
        record_del = UserStock.where(stock_id: params[:stock_id], user_id: params[:user_id]).first
        record_del_data ="stock_item_#{params[:stock_id]}"
        # binding.break
        record_del.destroy if record_del.present?
            
        
        #flash.now[:notice] = "#{params[:ticker]} was successfully removed from your data!"
        #binding.break
        respond_to do |format|
            format.turbo_stream { render "users/remove", 
                locals: {user_stock_record: record_del_data, flash_notice: "#{params[:ticker]} was successfully removed from your data!" }
            }
        end
        
    end
end
