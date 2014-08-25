# See Listing 10.25
class OccupationsController < ApplicationController
  # See Listing 10.46
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  # See Lisiting 9.23
  def index
    # Simple Search Form. See http://railscasts.com/episodes/37-simple-search-form.
    @occupations = Occupation.paginate(:per_page => 5, :page => params[:page]).search(params[:search])
  end

  # SEE LISTING 10.19, ADDED 02-MAY-14
  def show
    @occupation = Occupation.find(params[:id])
    @skill = Skill.new
    @skills = @occupation.skills.paginate(page: params[:page])
    # See Listing 10.19. also added , :per_page => 1 to limit pagination to show 1 occupation per page
    #@user = User.new
    @users = @occupation.inverse_friends 
    # Added this 26th July
    #@friend = @occupation.friendships.find_by(:occupation_id => params[:occupation_id])
    #@friend = Occupation.joins('INNER JOIN "friendships" ON "occupations"."id" = "friendships"."friend_id" WHERE "friendships"."user_id" = 1')   
    #@friend = @occupation.friendships.where(:occupation_id == :friend_id)
  end

  def create
  # See Listing 10.27
   @occupation = current_user.occupations.build(occupation_params)
    if @occupation.save
      flash[:success] = "Occupation created!"
      redirect_to root_url
    else
      # See Listing 10.42
      @feed_items = []
      render 'static_pages/home'
    end	
  end

  def destroy
    # See Listing 10.46
    @occupation.destroy
    redirect_to root_url
  end

  private
  # See Listing 10.27
   def occupation_params
    params.require(:occupation).permit(:content)
   end

  # See Listing 10.46
    def correct_user
      @occupation = current_user.occupations.find_by(id: params[:id])
      redirect_to root_url if @occupation.nil?
    end
end