class UsersController < ApplicationController
  def my_data
    @stock = Stock.new
    # binding.break
    # if(params[:stock])

    #   @search_data = Stock.new_lookup(params[:stock])

    #   # render 'my_data'
    # else 
    #   render 'my_data', status: :unprocessable_entity

    # end
  end


end