class UsersController < ApplicationController
  before_action :set_user,        only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user,  only: [:index, :edit, :update, :destroy]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      log_in @user
      flash[:success] = "Welcome to Grow and Swap!"
      redirect_to user_path(@user)
    else
      flash[:error] = "Could not create user"
      redirect_to new_user_path
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "User was successfully updated"
      redirect_to user_path(@user)
    else
      flash[:error] = "Could not update user"
      redirect_to edit_user_path(@user)
    end
  end

# Implement user destroy action only with admin user functionality

  def destroy
    @user.destroy
    flash[:success] = "User was successfully deleted"
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in"
      redirect_to login_path
    end
  end

  def correct_user
    set_user
    redirect_to root_path unless current_user?(@user)
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
