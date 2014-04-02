class StaticPagesController < ApplicationController
  def home
    if signed_in?
		  # See Listing 10.31
  	 @occupation = current_user.occupations.build 
     # See Listing 10.38
     @feed_items = current_user.feed.paginate(page: params[:page], :per_page => 1)
    end
  end

  def help
  end

  def about
  end	

  def contact
  end	
end
