class StudentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @students = current_user.students
  end

  def create
    student = current_user.students.find_by(name: params[:name], subject: params[:subject])

    if student
      student.marks += params[:marks].to_i
      student.save
    else
      current_user.students.create(name: params[:name], subject: params[:subject], marks: params[:marks])
    end

    redirect_to students_path
  end

  def update
    student = current_user.students.find(params[:id])
    student.update(student_params)
    render json: student
  end

  def destroy
    student = current_user.students.find(params[:id])
    student.destroy
    head :no_content
  end

  private

  def student_params
    params.require(:student).permit(:name, :subject, :marks)
  end
  
end
