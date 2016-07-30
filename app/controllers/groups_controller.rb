class GroupsController < ApplicationController
  def index
    @groups=Group.all
  end

  def new
    @group=Group.new
  end

  def create
    @group=Group.new(params_group)
    @group.save
    redirect_to groups_path
  end

  def edit
    @group=Group.find(params[:id])

  end

  def update
    @group=Group.find(params[:id])
    @group.update(params_group)
    redirect_to groups_path
  end

  def destroy
    @group=Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end
  
  private
  def params_group
    params.require(:group).permit(:title, :description)

  end
end
