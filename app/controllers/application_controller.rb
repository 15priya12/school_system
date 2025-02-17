class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

protected

def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
end

  protected
  # Redirect users after sign-in
  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      schools_path # Redirect Admins to /schools
    elsif resource.is_a?(School)
      "http://#{resource.username}.lvh.me:3000/students" # Redirect Schools to their subdomain
    else
      root_path
    end
  end
end
