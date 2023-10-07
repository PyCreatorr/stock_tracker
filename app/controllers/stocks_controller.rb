class StocksController < ApplicationController

    def search        
        
            if params[:stock].present?

                @stock = Stock.new_lookup(params[:stock])

                if @stock
                    # render 'users/my_data'

                        respond_to do |format|
                            format.turbo_stream { render "users/create"}
                        end
                            #format.turbo_stream { render 'users/create'}
                            #format.js { render partial: "users/result"}
                            #format.js { render partial: 'users/result' }
                        #    format.html {  render 'users/my_data' }
                           #format.html {  render 'users/my_data' }
                        
                    
                    else 
                        flash.now[:danger] = "Please enter a valid symbol to search"
                        # redirect_to my_data_path
                        respond_to do |format|
                            format.turbo_stream { render "users/create"}
                        end
                        #binding.break
                        # render json: @stock
                    end

            else 

                    # render users_url(my_data), status: :unprocessable_entity
                    # render 'users/my_data', status: :unprocessable_entity
                    flash.now[:alert] = "You need to place a symbol!"
                    respond_to do |format|
                        format.turbo_stream { render "users/create"}
                    end
                    # redirect_to my_data_path

            end

        

    end

end