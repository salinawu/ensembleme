class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def index
    @groups = Group.all
  end

  def join
    @group = Group.find(params[:id])
    current_user.groups << @group
    redirect_to @group
  end

  def leave
    @group = Group.find(params[:id])
    @group.users.delete(current_user)
    current_user.groups.delete(@group)
    if @group.users.length == 0
      @group.destroy
    end
    redirect_to current_user
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      @group.users << current_user
      current_user.groups << @group
      redirect_to @group
    else
      render 'new'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    redirect_to groups_path
  end

  private
    def group_params
      params.require(:group).permit(:name)
    end
end
