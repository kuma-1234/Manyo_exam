class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  
  def index
    @users = User.select(:id, :name, :email, :admin )
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
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice:'ユーザー情報を編集しました！'
    else
      render :edit
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.delete
    redirect_to admin_users_path, notice:'ユーザー情報に関するデータを全て削除しました'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def if_not_admin
    redirect_to root_path, notice:'管理者のみがアクセスできます' unless current_user.admin?
  end
end
