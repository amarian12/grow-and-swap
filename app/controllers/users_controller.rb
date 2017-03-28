class UsersController < ApplicationController
  before_action :set_user,        only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user,  only: [
                                          :gardeners_near_me,
                                          :index,
                                          :show,
                                          :edit,
                                          :update,
                                          :destroy
                                        ]
  before_action :authorized_user, only: [:edit, :update, :destroy]
  before_action :set_trade_offer_session_store, only: :show

  def gardeners_near_me
    @users = User.near([current_user.latitude, current_user.longitude], 20)
      .where.not(id: current_user.id)
      .paginate(page: params[:page], per_page: 15)
  end

  def index
    @users = User.all.paginate(page: params[:page], per_page: 15)
  end

  def show
    @hash = Gmaps4rails.build_markers(@user) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
    end
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
    logger.debug "Updated user: #{@user.attributes.inspect}"
    if @user.update_attributes(user_params)
      flash[:success] = "User was successfully updated"
      redirect_to user_path(@user)
    else
      flash[:error] = "Could not update user"
      redirect_to edit_user_path(@user)
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "User was successfully deleted"
      redirect_to root_path
    else
      flash[:error] = "Could not delete user"
      redirect_to user_path(@user)
    end
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

  def authorized_user
    redirect_to root_path unless current_user?(@user) || current_user.admin?
  end

  def set_trade_offer_session_store
    if params[:reciprocal_trade_offer_id].present?
      @trade_offer = TradeOffer.find(params[:reciprocal_trade_offer_id])
      session[:reciprocal_trade_offer_id] = @trade_offer.id
    end
  end

  def user_params
    params.fetch(:user, {}).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :avatar,
      :avatar_cache,
      :street,
      :city,
      :state,
      :zip_code,
      :country,
      garden_items_attributes: [:quantity]
    )
  end
end
