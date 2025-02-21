class Api::SchoolsController < ActionController::API
  before_action :switch_to_main_db

  def index
    schools = School.all
    render json: schools
  end

  def create
    school = School.new(school_params)
    if school.save
      render json: school, status: :created
    else
      render json: { errors: school.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    school = School.find(params[:id])
    if school.destroy
      render json: { message: "School deleted successfully" }, status: :ok
    else
      render json: { error: "Failed to delete school" }, status: :unprocessable_entity
    end
  end

  private

  def switch_to_main_db
    Apartment::Tenant.switch!('school_system_development') # Ensure we're in the main DB
  end

  def school_params
    params.require(:school).permit(:email, :password, :username)
  end
end