class GroupsController < ApplicationController
  before_action :authenticate_user!, only:[:new]

  def index
    @groups=Group.all
  end

  def new
    @group=Group.new
  end

  def create
    @group=Group.new(params_group)
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
    @group=Group.find(params[:id])

  end

  def update
    @group=Group.find(params[:id])
    if @group.update(params_group)
      redirect_to groups_path
    else
      render :edit
    end
  end

  def destroy
    @group=Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end

  def show
    @group=Group.find(params[:id])
  end

  private
  def params_group
    params.require(:group).permit(:title, :description)

  end
end
