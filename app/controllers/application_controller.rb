class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :extra_data

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to site_home
  end

  private

  def extra_data
    ''
  end

  def get_project
    @app_config ||= AppConfig.first
  end

  def after_sign_in_path_for(resource_or_scope)
    session[:redirect_url] || site_home
  end

  def after_sign_out_path_for(resource_or_scope)
    site_home
  end

  def site_home
    '/'
  end

  def default_home
    root_path
  end
end
