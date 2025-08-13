class ClassesController < ApplicationController
  def index
    # Load all grades with classrooms, homeroom_teacher, students and results preloaded
    @grades = Grade.includes(classrooms: [:homeroom_teacher, { students: :results }]).order(:name)
    
    # Calculate average performance per classroom
    @classroom_averages = {}

    @grades.each do |grade|
      grade.classrooms.each do |classroom|
        avg_score = classroom.students.joins(:results).average(:score) || 0
        @classroom_averages[classroom.id] = avg_score.round(2)
      end
    end
    
  end
end
