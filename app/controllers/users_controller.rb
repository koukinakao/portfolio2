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
  
  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end
  
  def facebook_login
  if callback_for(:facebook)
  @user = User.from_omniauth(request.env["omniauth.auth"])
    result = @user.save
    if result
      log_in @user
      flash[:success] = "facebookアカウントでログインしました。"
      redirect_to root_path
    else
      redirect_to auth_failure_path
    end
  end
  end
  
  def google_login
    if callback_for(:google)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    result = @user.save
    if result
      log_in @user
      flash[:success] = "googleアカウントでログインしました。"
      redirect_to root_path
    else
      redirect_to auth_failure_path
    end
  end
  end

  #認証に失敗した際の処理
  def auth_failure 
    @user = User.new
    flash.now[:danger] = 'ログインに失敗しました。'
    render 'sessions/new'
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.create(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ログインしました。"
      redirect_to books_posts_path(id: @user.id)
    else
      flash.now[:danger] = 'アカウントの作成に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to books_posts_path(id: @user.id)
    else
      flash.now[:danger] = 'ユーザー情報の更新に失敗しました。'
      render :edit
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました。"
    redirect_to root_path
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
end
