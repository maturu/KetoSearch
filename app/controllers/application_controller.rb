class ApplicationController < ActionController::Base
  after_action  :store_location
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_variables
    flash['alert']=nil
  end

  def after_sign_in_path_for(resource)
    if (session[:previous_url] == root_path)
      super
    else
      session[:previous_url] || root_path
    end
  end

  def after_sign_up_path_for(resource)
    new_user_session_path
  end

  private
    def sign_in_required
      redirect_to new_user_session_url unless user_signed_in?
    end

    def store_open_required
      redirect_to store_new_path unless current_user.store
    end

    def pc_only
      redirect_to root_path if browser.device.mobile?
    end

    def store_location
      if (request.fullpath != "/users/sign_in" and
          request.fullpath != "/users/sign_up" and
          request.path_info != "/users/confirmation" and
          request.fullpath !~ Regexp.new("\\A/users/password.*\\z") and
          !request.xhr?) # don't store ajax calls
        session[:previous_url] = request.fullpath 
      end
    end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end
end
