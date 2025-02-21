class Api::StudentsController < ActionController::API
  before_action :authenticate_school!
  before_action :switch_to_tenant_db

  def index
    students = Student.all
    render json: students
  end

  def create
    student = Student.new(student_params)
    if student.save
      render json: student, status: :created
    else
      render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def switch_to_tenant_db
    return unless current_school

    school_subdomain = request.subdomain
    if school_subdomain.present?
      Apartment::Tenant.switch!(school_subdomain)
    else
      render json: { error: "Invalid tenant" }, status: :unprocessable_entity
    end
  end

  def student_params
    params.require(:student).permit(:email, :password)
  end
end