class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    # @postings = @user.postings.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to your profile!"
      redirect_to @user

      #if you want account activation upon signup
      # @user.send_activation_email
      # flash[:info] = "Please check your email to activate your account."
      # redirect_to root_url
      # Handle a successful save.
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
     @user = User.find(params[:id])
     if @user.update_attributes(user_params)
       flash[:success] = "Profile updated"
       redirect_to @user
       # Handle a successful update.
     else
       render 'edit'
     end
   end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :instrument,
                                   :location, :expertise, :commitment, :bio)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
