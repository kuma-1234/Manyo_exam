class UsersController < ApplicationController
  skip_before_action :login_required, only:[ :new, :create ]

  def new
    if logged_in?
      redirect_to tasks_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash.now[:notice] = 'アカウントを作成しました！'
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: 'ログインしました！'
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
      unless @user == current_user
        redirect_to tasks_path, notice:'ログインIDとアクセスしようとしているIDが一致しません。'
      end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
