class ResourcesController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user,   only: :destroy

  def create
    @occupation = Occupation.find(params[:occupation_id])
    @skill = Skill.find(params[:skill_id])
    @resource = current_user.resources.build(resource_params)
    @resource.skill = @skill
    
    if @resource.save
      flash[:success] = "Resource created!"
      redirect_to @skill
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @resource.destroy
    redirect_to root_url
  end

  private
    def resource_params
      params.require(:resource).permit(:content)
    end

    def correct_user
      @resource = current_user.resources.find_by(id: params[:id])
      redirect_to root_url if @resource.nil?
    end
end