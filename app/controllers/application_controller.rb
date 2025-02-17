class ApplicationController < ActionController::Base
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
