class FriendshipsController < ApplicationController

    def create
        #binding.break

        friendship = Friendship.find_by(user_id: params[:user], friend_id: params[:friend])
        

        if !friendship.nil?
            flash.now[:notice] = "The friend #{params[:full_name]} #{params[:email]} is already trackt!"  
            #redirect_to my_friends_path      

            respond_to do |format|
                format.turbo_stream { render "users/new_friend", 
                    locals: { friend: "", allowed: false,  flash_notice: "The friend #{params[:full_name]} #{params[:email]} is already trackt!" }
                }
            end
        else
            @friend = Friendship.create(user_id: params[:user], friend_id: params[:friend])
            friend = User.find(@friend.friend_id)
            #record_new_data ="friend_item_#{@friend.id}"


            flash.now[:notice] = "The friend #{params[:full_name]} #{params[:email]} was successfully added to your friends!"
            # redirect_to my_friends_path

            respond_to do |format|
                format.turbo_stream { render "users/new_friend", 
                    locals: {friend: friend, allowed: true, flash_notice: "#{params[:email]} was successfully added to your friends!" }
                }
            end

        end

    end

    def destroy
        record_del = Friendship.where(friend_id: params[:friend_id], user_id: params[:user_id]).first
        record_del_data ="friend_item_#{params[:friend_id]}"
        # binding.break
        record_del.destroy if record_del.present?
            
        
        flash.now[:notice] = "#{params[:ticker]} was successfully removed from your data!"
        #binding.break
        respond_to do |format|
            format.turbo_stream { render "users/remove", 
                locals: {user_stock_record: record_del_data, flash_notice: "#{params[:email]} was successfully removed from your friends!" }
            }
        end
    end
end
