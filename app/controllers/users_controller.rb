class UsersController < ApplicationController
  def my_data
    @stock = Stock.new
    @user_stocks = current_user.stocks
    # binding.break
    # if(params[:stock])

    #   @search_data = Stock.new_lookup(params[:stock])

    #   # render 'my_data'
    # else 
    #   render 'my_data', status: :unprocessable_entity

    # end
  end

  def my_friends
    @friend = User.new
    @friends = current_user.friends
  end

  def search
    #binding.break
    #render json: params[:friend]
    #binding.break    

    if !params[:friend].empty?

      # @stock = Stock.new_lookup(params[:stock])
      # strip! - removes empty signs
      @friends = User.find_friends(params[:friend])      
      
      if @friends
          # exclude current user from the friends list
          @friends = current_user.except_current_user(@friends)

              respond_to do |format|
                  format.turbo_stream { render "users/create_friends"}
              end
             
          
      else 
              flash.now[:danger] = "Please enter a valid symbol to search"
              # redirect_to my_data_path
              respond_to do |format|
                  format.turbo_stream { render "users/create_friends"}
              end
              #binding.break
              # render json: @stock
      end
          

    else 
              flash.now[:alert] = "You need to place a symbol!"
              respond_to do |format|
                  format.turbo_stream { render "users/create_friends"}
              end
    end
              # redirect_to my_data_path

  end





end
