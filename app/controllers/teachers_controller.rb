class TeachersController < ApplicationController
  def index
    # Load teachers with their lectures (which contain subjects and grades)
    @teachers = Teacher.includes(lectures: [ :subject, :grade ]).all

    # Prepare a hash to store averages keyed by teacher_id + subject_id + grade_id
    @averages = {}

    @teachers.each do |teacher|
      teacher.lectures.group_by { |lec| [ lec.subject_id, lec.grade_id ] }.each do |(subject_id, grade_id), lectures|
        # Find all students in this grade
        student_ids = Student.where(grade_id: grade_id).pluck(:id)

        # Find all results for these students in this subject
        avg_score = Result.where(subject_id: subject_id, student_id: student_ids).average(:score) || 0

        @averages[[ teacher.id, subject_id, grade_id ]] = avg_score.round(2)
      end
    end
  end
end
