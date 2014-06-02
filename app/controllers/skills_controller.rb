class SkillsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @occupation = Occupation.find(params[:occupation_id])
    @skill = current_user.skills.build(skill_params)
    @skill.occupation = @occupation

    #@skill = current_user.skills.build(skill_params)
    if @skill.save
      flash[:success] = "Skill created!"
      #redirect_to root_url
      redirect_to @occupation
    else
      # See Listing 10.42
      @skillfeed_items = []
      render 'static_pages/home'
    end

    #http://stackoverflow.com/questions/7261636/rails-3-couldnt-find-model-without-an-id-problem
    #@occupation = Occupation.find(params[:occupation_id])
    #@skill = @occupation.skills.build(params[:skill])
    #@skill.user = User.find(current_user.id)

    #had this and worked once @skill = @occupation.skills.build(params[:skill][:occupation_id])
    #@skill = Skill.new(params[:skill])
    #@skill.occupation = @skill

  end

  def destroy
    # See Listing 10.46
    @skill.destroy
    #redirect_to :back
    redirect_to root_url
  end

  private

    def skill_params
      params.require(:skill).permit(:content)
    end

    # See Listing 10.46
    def correct_user
      @skill = current_user.skills.find_by(id: params[:id])
      #redirect_to :back
      redirect_to root_url if @skill.nil?
    end
end