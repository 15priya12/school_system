class ApplicationController < ActionController::Base
  before_action :set_tenant

  private

  def set_tenant
  
    # Find the school based on the subdomain
    school = School.find_by(username: request.subdomain)
    
    if school
      Apartment::Tenant.switch!("school_#{school.id}")
    else
      render plain: "Tenant not found", status: :not_found
    end
  end
end
