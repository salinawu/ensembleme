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
    flash[:info] = @group.name
    tmp = User.near(current_user.location, params[:vicinity])
    # flash[:info] = tmp.length
    if tmp.empty?
      flash[:info] = current_user.location
    end
    if !params[:vicinity].present? or tmp.empty?
      tmp = User.all
    end

    used = []
    if @group.save
      if params[:members].present?
        instruments = params[:members].split(/[\s,']/)
        # flash[:info] = instruments
        instruments.each do |i|
          xs = tmp.select{ |u| u[:instrument].downcase == i.downcase }
          xs = xs - used
          # flash[:info] = xs.length
          if !xs.any?
            next
          else
            # flash[:info] = "success"
            best = xs.first
            score = (xs.first.expertise.to_i - current_user.expertise.to_i).abs +
            (xs.first.commitment.to_i - current_user.commitment.to_i).abs
          end
          xs.each do |x|
            if used.include?(x)
              break
            else
              cmp = (x.expertise.to_i - current_user.expertise.to_i).abs +
              (x.commitment.to_i - current_user.commitment.to_i).abs
              if cmp < score
                best = x
                score = cmp
              end
            end
          end
          @group.users << best
          used << best
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

  def update
    @group = Group.find(params[:id])

    if @group.update(group_params)
      redirect_to @group
    else
      render 'edit'
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    redirect_to groups_path
  end

  private
    def group_params
      params.require(:group).permit(:name, :bio)
    end
end
