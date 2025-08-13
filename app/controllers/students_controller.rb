class StudentsController < ApplicationController
  def index
    @grades = Grade.order(:name)  # for the dropdown
    
    if params[:grade_id].present?
      @selected_grade = Grade.find_by(id: params[:grade_id])
      @students = Student.includes(:grade, :classroom, :results)
                         .where(grade: @selected_grade)
                         .order('grades.name, students.last_name, students.first_name')
                         .references(:grade)
    else
      @students = Student.includes(:grade, :classroom, :results)
                         .order('grades.name, students.last_name, students.first_name')
                         .references(:grade)
    end
  end
end
