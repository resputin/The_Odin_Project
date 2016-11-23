class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :logged_in?, :author

  def current_user
    if session[:user_id]
      current_user ||= User.find(session[:user_id])
    elsif cookies.signed[:remember_token]
      hash = Digest::SHA1.hexdigest(cookies.signed[:remember_token].to_s)
      current_user ||= User.find_by(hash)
    else
      return nil
    end
  end

  def current_user=(user)
    current_user = user
  end

  def log_in(user)
    session[:user_id] = user.id
    user.set_remember_token
    cookies.permanent[:remember_token] = user.remember_digest
  end

  def sign_out(user)
    cookies.permanent[:remember_token] = nil
    @current_user = nil
    session.clear
  end

  def logged_in?
    session[:user_id] != nil
  end

  def author(post)
    User.find(post.user_id).name
  end
end
