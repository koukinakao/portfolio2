class SessionsController < ApplicationController
  layout 'users'
  
  def new
  end
  
  def create
    #ユーザーをデータベースから見つけて検証する
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      #ユーザーにログインする
      log_in user
      #[remember me] チェックボックスの送信結果を処理する
      params[:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = "Welcome to the Sample App!"
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render :new
    end
  end
  
  def destroy
    #ログイン中の場合のみログアウトする
    log_out if logged_in?
    redirect_to root_url
  end
  
end
