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

  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
end
