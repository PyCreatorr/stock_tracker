class StocksController < ApplicationController

    def search        
        
            if params[:stock].present?

                @stock = Stock.new_lookup(params[:stock])

                if @stock
                    # render 'users/my_data'

                        respond_to do |format|
                            #format.turbo_stream { render 'users/create'}
                            #format.js { render partial: "users/result"}
                            format.turbo_stream { render "users/create"}
                        #    format.html {  render 'users/my_data' }
                           #format.html {  render 'users/my_data' }
                        end
                    
                    else 
                        flash[:danger] = "Please enter a valid symbol to search"
                        redirect_to my_data_path
                        #binding.break
                        # render json: @stock
                    end

            else 

                    # render users_url(my_data), status: :unprocessable_entity
                    # render 'users/my_data', status: :unprocessable_entity
                    flash[:alert] = "You need to place a symbol!"
                    redirect_to my_data_path

            end

        

    end

end