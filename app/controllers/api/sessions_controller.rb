class Api::SessionsController < Devise::SessionsController

    respond_to :json
  
    def create
      if params[:admin]
        # Force query on the MAIN database for Admins
        Apartment::Tenant.switch!('school_system_development') 
  
        admin = Admin.find_by(email: params[:admin][:email])
        if admin&.valid_password?(params[:admin][:password])
          sign_in(admin)
          render json: { message: "Logged in successfully", user: admin }, status: :ok
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      elsif params[:school]
        # Schools are in their respective tenant databases (subdomains)
        school = School.find_by(email: params[:school][:email])
        if school&.valid_password?(params[:school][:password])
          sign_in(school)
          render json: { message: "Logged in successfully", user: school }, status: :ok
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      else
        render json: { error: "Invalid request format" }, status: :bad_request
      end
    end
  
    def destroy
      if current_admin || current_school
        sign_out(current_admin || current_school)
        render json: { message: "Logged out successfully" }, status: :ok
      else
        render json: { error: "No active session" }, status: :unauthorized
      end
    end
  end