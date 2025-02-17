class School < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    after_create :create_tenant
  
    private
  
    def create_tenant
      Apartment::Tenant.create(username) # Create schema with school username
    end
  end
  