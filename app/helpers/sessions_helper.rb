module SessionsHelper
  
  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # ユーザーのセッションを永続的にする
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # 記憶トークンcookieに対応するユーザーを返す
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
　   　  #ログインする
         log_in user
        @current_user = user
      end
    end
  end
  
  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end
  
  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user || current_user.admin?
  end
  
  # 管理者かどうか確認
  def admin_user
    unless current_user.admin?
      flash[:danger] = 'Do not have the authority'
      redirect_to(root_url) 
    end
  end
  
  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
end
