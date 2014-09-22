class FriendshipsController < ApplicationController
# See Listing 10.46
before_action :signed_in_user, only: [:create, :destroy]
before_action :correct_user, only: :destroy

# http://railscasts.com/episodes/163-self-referential-association
def create
  @friendship = current_user.friendships.build(:friend_id => params[:friend_id], :occupation_id => params[:friend_id])
  if @friendship.save
    flash[:notice] = "Added Occupation."
    redirect_to :back
    #redirect_to root_url
  else
    flash[:error] = "Unable to add Occupation."
    redirect_to root_url
  end
end

def destroy
  @friendship = current_user.friendships.find(params[:id])
  @friendship.destroy
  flash[:notice] = "Removed Occupation."
  redirect_to current_user
end

private
  # See Listing 10.46
    def correct_user
      @friendship = current_user.friendships.find_by(id: params[:id])
      redirect_to root_url if @friendship.nil?
    end

end
