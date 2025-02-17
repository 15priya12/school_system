class School < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    after_create :create_tenant
    validates :username, presence: true, uniqueness: true

  
    private
  
    def create_tenant
      return if username.blank?  # Prevents running if username is nil or empty
    
      db_name = username # Define database name convention
    
      begin
        ActiveRecord::Base.connection.execute("CREATE DATABASE #{db_name}") # Create database
        ActiveRecord::Base.connection.execute("USE #{db_name}") # Switch to that database
        ActiveRecord::Base.connection.execute("CREATE TABLE students (
          id INT AUTO_INCREMENT PRIMARY KEY,
          email VARCHAR(255) UNIQUE,
          password_digest VARCHAR(255) ,
          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        )") # Create students table
      rescue StandardError => e
        Rails.logger.error "Error creating tenant database: #{e.message}"
      end
    end
    
      
  end
  