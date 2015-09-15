class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

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
      redirect_to(root_path)
    else
      flash[:error] = "Could not create user"
      redirect_to(new_user_path)
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "User was successfully updated"
      redirect_to(root_path)
    else
      flash[:error] = "Could not update user"
      redirect_to edit_user_path(@user)
    end
  end

# Implement user destroy action only with admin user functionality

  # def destroy
  #   if @user.valid?
  #     @user.destroy
  #     flash[:success] = "User was successfully deleted"
  #   else
  #     flash[:error] = "Could not delete user"
  #   end
  #   redirect_to(root_path)
  # end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
