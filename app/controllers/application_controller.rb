class ApplicationController < ActionController::Base
  before_action :set_tenant

  private

  def set_tenant
    return if request.subdomain.blank? || request.subdomain == "www"

    school = School.find_by(username: request.subdomain) # Find school by subdomain
    if school
      Apartment::Tenant.switch!(school.username) # Now we directly use `username` for schema
    else
      render plain: "School not found", status: :not_found
    end
  end
end
