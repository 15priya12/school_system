class SchoolsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @schools = School.all
  end

  def new
    @school = School.new
  end

  def create
    @school = School.new(school_params)
    if @school.save
      redirect_to schools_path, notice: "School created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end
  def destroy
    @school = School.find(params[:id])
    @school.destroy
    redirect_to schools_path, notice: "School deleted successfully."
  end
  

  private

  def school_params
    params.require(:school).permit(:username, :password)
  end
end
