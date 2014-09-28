class SessionsController < ApplicationController
	def new
  end

  def create
    # 24th Septmember 2014. Adding Google Signin. See http://richonrails.com/articles/google-authentication-in-ruby-on-rails
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
    # End

  	# See Listing 8.10. Note because we are using Bootstrap we automatically get the flash image.
  	#user = User.find_by(email: params[:session][:email].downcase)
    #if user && user.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page, See Listing 8.13
    #  sign_in user
      #See Listing 9.19
    #  redirect_back_or user
      #redirect_to user
    #else
      # Listing 8.12
    #  flash.now[:error] = 'Invalid email/password combination'
      #flash[:error] = 'Invalid email/password combination' # Note: this code cause the flash to show on all pages.
  		# See Listing 8.9
  	#	render 'new'
  	#end	
  end

  def destroy
    # 24th Septmember 2014. Adding Google Signin. See http://richonrails.com/articles/google-authentication-in-ruby-on-rails
    session[:user_id] = nil
    # End

    # See Listing 8.29
    # Hidden to implement Google signin
    #sign_out
    redirect_to root_url
  end
end
