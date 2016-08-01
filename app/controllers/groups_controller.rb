class GroupsController < ApplicationController
  before_action :authenticate_user!, only:[:new,:create, :edit, :update, :destroy]
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]

  def index
    @groups=Group.all
  end

  def new
    @group=Group.new
  end

  def create
    @group=Group.new(params_group)
    @group.user=current_user
    if @group.save
      current_user.join!(@group)
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit

  end

  def update

    if @group.update(params_group)
      redirect_to groups_path
    else
      render :edit
    end
  end

  def destroy

    @group.destroy
    redirect_to groups_path
  end

  def show
    @group=Group.find(params[:id])
    @posts=@group.posts.order("created_at DESC")
  end

  def join
    @group=Group.find(params[:id])
    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice]="add in group successfully!"
    else
      flash[:warning]="You are already the member of the group"
    end

    redirect_to group_path(@group)
  end

  def quit
    @group=Group.find(params[:id])
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = "withdraw from the group successfully"
    else
      flash[:warning]="You are not the member of the group originally"
    end
    redirect_to group_path(@group)
  end







  private
  def params_group
    params.require(:group).permit(:title, :description)

  end

  private

 def find_group_and_check_permission
   @group = Group.find(params[:id])

   if current_user != @group.user
     redirect_to root_path, alert: "You have no permission."
   end
 end



end
