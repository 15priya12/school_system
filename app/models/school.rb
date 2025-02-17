class School < ApplicationRecord
    after_create :create_tenant
  
    private
  
    def create_tenant
      Apartment::Tenant.create(username) # Create schema with school username
    end
  end
  