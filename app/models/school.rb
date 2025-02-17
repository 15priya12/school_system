class School < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    after_create :create_tenant
    validates :username, presence: true, uniqueness: true

  
    private
  
    def create_tenant
        return if username.blank?  # Prevents Apartment from running if username is nil or empty
        Apartment::Tenant.create(username)
      end
      
  end
  