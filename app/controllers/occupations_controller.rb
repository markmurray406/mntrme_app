# See Listing 10.25
class OccupationsController < ApplicationController
  # See Listing 10.46
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  # SEE LISTING 10.19, ADDED 02-MAY-14
  def show
    @occupation = Occupation.find(params[:id])
    @skill = Skill.new
    @skills = @occupation.skills.paginate(page: params[:page])
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