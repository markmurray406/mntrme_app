module SessionsHelper
	# See Listing 8.19
	 def sign_in(user)
	 	# Step 1. create a new token
    remember_token = User.new_remember_token
		# Step 2. Place the unencrypted token in the browser cookies
    cookies.permanent[:remember_token] = remember_token
    # Step 3. Save the encrypted token to the database
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    # Step 4. Set the current user equal to the given user
    self.current_user = user
  end

	# See Listing 8.23
  def signed_in?
    !current_user.nil?
  end

	# See Listing 8.20
  def current_user=(user)
    @current_user = user
  end

	# See Listing 8.22, finding the user using the remember_token.
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  # See Listing 9.15
  def current_user?(user)
    user == current_user
  end

  # See Listing 10.24. Note User controller signed_in user is hidden because of this.
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end  

  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  # See Listing 9.17
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end
