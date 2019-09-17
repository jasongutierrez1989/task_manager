class UsersController < ApplicationController
    before_action :require_login, except: [:new, :create]

    def index
        @users = User.all
    end
    
    def new
        @user = User.new
    end  

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user), notice: "User sign up was successful."
        else
            redirect_to new_user_path, error: "Error: #{@user.errors.full_messages.join(", ")}"
        end
    end

    def show
        @user = User.find_by(id: params[:id])
    end

    def edit
        @user = User.find_by(id: current_user.id)
        render :edit
    end

    def update
        @user = User.find_by(id: params[:id])

        @user.update(user_params)
        if @user.save
            redirect_to user_path(@user)
        else
            redirect_to edit_user_path(@user), error: "Error: #{@user.errors.full_messages.join(", ")}"
        end
    end

    def destroy
        if User.find_by(:id => params[:id]) == current_user
            User.find_by(:id => params[:id]).destroy
            session.clear   # if admin deletes themself, they get logged out
            redirect_to '/'
        elsif User.find_by(:id => params[:id]).destroy
            User.find_by(:id => params[:id]).destroy
            flash[:notice] = "Crew record deleted."
            redirect_to users_path
        else
            redirect_to users_path, error: "This action requires clearance"
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :job, :email, :uid, :password, :password_confirmation, :location_ids => [])
    end
end