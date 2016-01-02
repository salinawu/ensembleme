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
    nearby = User.near(params[:location], params[:vicinity])
    if params[:vicinity].present? and !nearby.empty?
      @users = nearby
    else
      @users = User.all
    end
    @users = User.all

    if @group.save
      if params[:members].present?
        instruments = params[:members].split(/[\s,']/)
        puts instruments
        instruments.each do |i|
          xs = @users.select{ |u| u[:instrument].downcase == i.downcase }
          if !xs.any?
            break
          else
            best = xs.first
            score = (xs.first.expertise.to_i - current_user.expertise.to_i).abs +
            (xs.first.commitment.to_i - current_user.commitment.to_i).abs
          end
          xs.each do |x|
            cmp = (x.expertise.to_i - current_user.expertise.to_i).abs +
            (x.commitment.to_i - current_user.commitment.to_i).abs
            if cmp <= score
              best = x
              score = cmp
            end
          end
          # @users.delete(best)
          @group.users << best
        end

        @group.users << current_user
        redirect_to @group
      else
        @group.users << current_user
        redirect_to @group
      end

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
