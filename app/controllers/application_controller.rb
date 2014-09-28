class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

 # 24th September 14 Adding Google Signin. See http://richonrails.com/articles/google-authentication-in-ruby-on-rails
 # The current_user function will check to see if the user_id exists in the session. If so it will return the current user. 
 # The helper method tells rails we wish to use this in our helpers and views as well. 
  helper_method :current_user


  # See Listing 8.14
  include SessionsHelper

# 24th September 14. Adding Google Signin. See http://richonrails.com/articles/google-authentication-in-ruby-on-rails
def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end


