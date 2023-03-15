class UsersController < ApplicationController
    def new
        @user = User.new
        render :new 
    end

    def create 
        user = User.new(strong_params)
        if user.save! 
            redirect_to user_url(user.id)
        else
            redirect_to new_userl_url
        end
    end

    def show
        @user = User.find_by(id: params["id"])
        render :show
    end


    def strong_params
        params.require(:user).permit(:email,:password)
    end
end
