class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  before_action :set_user, only: [ :edit, :update, :destroy ]
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def show
    @user = User.all
  end

  private
  def user_params
    params.require(:user).permit( :name, :email, :password, :password_confirmation, :admin )
  end

  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end
end
