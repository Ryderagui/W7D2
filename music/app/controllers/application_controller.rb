class ApplicationController < ActionController::Base
#CRRLLL
protect_from_forgery with: :exception 
helper_method :current_user 


def current_user
    current_token = session[:session_token]
    @current_user ||= User.find_by(session_token: current_token)
end

def require_logged_in
    if !logged_in?
        redirect_to new_session_url
    end
end

def require_logged_out
    if logged_in?
       redirect_to new_session_url
    end
end

def logged_in?
    !!current_user
end

def login(user)
    session[:session_token] = user.reset_session_token!
end

def logout
    if logged_in?
        current_user.reset_session_token!
    end
    session[:session_token] = nil
    @current_user = nil
end 





end
