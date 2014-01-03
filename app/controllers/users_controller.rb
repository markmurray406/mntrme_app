class UsersController < ApplicationController
	def show
	  @user = User.find(params[:id])
	end

	def new
		# See Listing 7.18
		@user = User.new
	end

	def create
		# See Listing 7.21
    #@user = User.new(params[:user])    # Not the final implementation!
    @user = User.new(user_params) # See Listing 7.22
    if @user.save
      # See Listing 7.28
      flash[:success] = "Welcome to Mntr Me!"
      # See Listing 7.26
      redirect_to @user
      # Handle a successful save.
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
   end
end
