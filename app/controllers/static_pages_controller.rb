class StaticPagesController < ApplicationController
  def home
    # Added to allow sign up on the landing page using email only, 02-Nov-14
    @user = User.new
    
    if signed_in?
		  # See Listing 10.31
  	 @occupation = current_user.occupations.build 
     @skill = current_user.skills.build 
     # See Listing 10.38
     @feed_items = current_user.feed.paginate(page: params[:page], :per_page => 5)
    end
  end

  def help
  end

  def about
  end	

  def contact
  end	
end
