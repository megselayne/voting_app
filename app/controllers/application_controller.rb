class ApplicationController < ActionController::Base
    helper_method :current_user_email

    def current_user_email
      @current_user_email ||= User.find_by(id: session[:user_id])&.email
    end
end