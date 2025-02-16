class School < ApplicationRecord
    after_create :create_tenant
  
    private
  
    def create_tenant
      Apartment::Tenant.create("school_#{id}")
    end
  end
  