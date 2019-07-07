class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :current_user
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :admin_user,     only: [:index]
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def facebook_login
  @user = User.from_omniauth(request.env["omniauth.auth"])
    result = @user.save
    if result
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to root_path
    else
      redirect_to auth_failure_path
    end
  end
  
  def google_login
  @user = User.from_omniauth(request.env["omniauth.auth"])
    result = @user.save
    if result
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to root_path
    else
      redirect_to auth_failure_path
    end
  end

#認証に失敗した際の処理
def auth_failure 
  @user = User.new
  flash.now[:danger] = 'failed to login'
  render 'sessions/new'
end

  def new
    @user = User.new
  end
  
  def create
    @user = User.create(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to books_posts(id: @user.id)
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "user updated"
      redirect_to books_posts(id: @user.id)
    else
      render :edit
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
end
