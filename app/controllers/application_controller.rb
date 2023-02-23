class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  
  #非ログイン時にTop,Aboutページ以外にアクセスできない様にする
  before_action :authenticate_user!, except: [:top, :about]
  
    #sign_in時の移行先
  def after_sign_in_path_for(resource)
      user_path(current_user)
  end
  
  #sign_out時の移行先
  def after_sign_out_path_for(resource)
      '/'
  end
  
  #deviseでnameが扱える様にする
  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
