class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ✅ Ensure API requests return JSON instead of HTML
  before_action :ensure_json_request, if: -> { request.format.json? }

  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      schools_path
    elsif resource.is_a?(School)
      "http://#{resource.username}.lvh.me:3000/students"
    else
      root_path
    end
  end

  private

  # ✅ Force JSON responses for API requests
  def ensure_json_request
    request.format = :json unless request.format.html?
  end
end
