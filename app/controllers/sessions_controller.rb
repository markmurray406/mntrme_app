class SessionsController < ApplicationController
	def new
  end

  def create
  	# See Listing 8.10. Note because we are using Bootstrap we automatically get the flash image.
  	user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page, See Listing 8.13
      sign_in user
      #See Listing 9.19
      redirect_back_or user
      #redirect_to user
    else
      # Listing 8.12
      flash.now[:error] = 'Invalid email/password combination'
      #flash[:error] = 'Invalid email/password combination' # Note: this code cause the flash to show on all pages.
  		# See Listing 8.9
  		render 'new'
  	end	
  end

  def destroy
    # See Listing 8.29
    sign_out
    redirect_to root_url
  end
end
