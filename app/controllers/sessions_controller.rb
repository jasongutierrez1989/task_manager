class SessionsController < ApplicationController
    before_action :require_login, only: [:logout]
    before_action :set_user, only: [:home]

    def welcome
    end

    def home
    end

    def new
        @user = User.new
        render 'login'
    end

    def facebook
        @user = User.find_or_create_by(uid: auth['uid']) do |c|
            c.name = auth['info']['name']
            c.email = auth['info']['email']
            c.password = SecureRandom.urlsafe_base64
            c.job ||= "Contributor"
        end
        if @user.save
            session[:user_id] = @user.id
            redirect_to home_path
        else
            redirect_to root_path
        end
    end

    def login
        @user = User.find_by(name: params[:user][:name])
        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect_to home_path
        else
            redirect_to login_path
        end
    end
    
    def logout
        if session[:user_id]
            session.clear
            redirect_to root_path
        else
            redirect_to home_path
        end
    end

    private

    def auth
        request.env['omniauth.auth']
    end

    def set_user
        @user = User.find_by(:id => session[:user_id])
    end
end