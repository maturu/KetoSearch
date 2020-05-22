class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_variables
    gon.data = {}.to_json
    flash['alert']=nil
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_up_path_for(resource)
    new_user_session_path
  end

  private
    def sign_in_required
      redirect_to new_user_session_url unless user_signed_in?
    end

    def approve_rank_required
      redirect_to root_path unless current_user.approve >= 10
    end

    def pc_only
      redirect_to root_path if browser.device.mobile?
    end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end
end
