class Api::StudentsController < ActionController::Base  # ✅ Use ActionController::Base for session support
  before_action :authenticate_school!
  before_action :switch_to_tenant_db

  def index
    students = Student.all
    render json: students
  end

  def create
    Rails.logger.info "Creating student in tenant: #{Apartment::Tenant.current}"

    student = Student.new(student_params)

    if student.save
      Rails.logger.info "Student created successfully: #{student.inspect}"
      render json: student, status: :created
    else
      Rails.logger.error "Failed to create student: #{student.errors.full_messages.join(", ")}"
      render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def switch_to_tenant_db
    return unless current_school

    school_subdomain = request.subdomain
    Rails.logger.info "Switching to tenant database: #{school_subdomain}"

    if school_subdomain.present? && Apartment.tenant_names.include?(school_subdomain)
      Apartment::Tenant.switch!(school_subdomain)
    else
      Rails.logger.error "Invalid or missing tenant: #{school_subdomain}"
      render json: { error: "Invalid tenant" }, status: :unprocessable_entity
    end
  end

  def student_params
    params.require(:student).permit(:email, :password)
  end
end
