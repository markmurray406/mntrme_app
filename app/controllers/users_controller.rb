class UsersController < ApplicationController
  # Listing 9.12, 9.21 and 9.44, See Listing 10.24 why this is hidden.
  #before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  # Listing 9.14
  before_action :correct_user, only: [:edit, :update]
  # Listing 9.46
  before_action :admin_user, only: :destroy
	
  # See Lisiting 9.23
  def index
    #@users = User.all
    # Simple Search Form. See http://railscasts.com/episodes/37-simple-search-form.
    @users = User.paginate(:per_page => 5, :page => params[:page]).search(params[:search])

    # See Listing 9.34
    #@users = User.paginate(page: params[:page])

    #@products = Product.search(params[:search]).paginate(:per_page => 5, :page => params[:page])
  end

  def show
	  @user = User.find(params[:id])
    # See Listing 10.19. also added , :per_page => 1 to limit pagination to show 1 occupation per page
    @occupations = @user.occupations.paginate(page: params[:page], :per_page => 5)
    # See Listing 10.19. also added , :per_page => 1 to limit pagination to show 1 occupation per page
    @skills = @user.skills.paginate(page: params[:page], :per_page => 5)
    # See Listing 10.19. also added , :per_page => 1 to limit pagination to show 1 occupation per page
    @resources = @user.resources.paginate(page: params[:page], :per_page => 5)
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
      # See Listing 8.27
      sign_in @user
      # See Listing 7.28
      flash[:success] = "Welcome to Mntr Me!"
      # See Listing 7.26
      redirect_to root_path
      # Handle a successful save.
    else
      render 'new'
    end
  end

  # See Listing 9.2
  def edit
    # See Listing 9.14, Now that the correct_user before filter defines @user, we can omit the following
    #@user = User.find(params[:id])
  end

  # See Listing 9.8
  def update
    # Note the use of user_params in the call to update_attributes, which uses strong parameters to prevent mass assignment vulnerability 
    # See Listing 9.14, why the following is omitted.
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update. Listing 9.10
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # Listing 9.44
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private

    def user_params
      # Added {:user_ids =>[]} to resolve #<ActiveRecord::Associations::CollectionProxy::ActiveRecord_Associations_CollectionProxy_User:0x007fa45dc513a0> problem
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :company)
    end

    # Before filters, Listings 9.18
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # See Listings 9.46
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
