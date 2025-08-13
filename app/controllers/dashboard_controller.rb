class DashboardController < ApplicationController
  def index
    # Fetch all grades with students and attendance preloaded for efficiency
    @grades = Grade.includes(:students).all

    # Total students in the school
    @total_students = Student.count

    # Prepare data hashes keyed by grade id
    @average_attendance_by_grade = {}
    @top_students_by_grade = {}
    @average_score_by_grade = {}
    @student_count_by_grade = {}
    @top_classes_by_grade = {}

    monthly_fee = 5300
    total_students = @total_students

    # Loop over each grade to calculate stats
    @grades.each do |grade|
      students = grade.students

      # Count students in this grade
      @student_count_by_grade[grade.id] = students.size

      # Average attendance rate for the grade (percentage)
      attendance_records = students.flat_map(&:attendances)
      if attendance_records.any?
        present_count = attendance_records.count { |a| a.present }
        total_count = attendance_records.size
        @average_attendance_by_grade[grade.id] = ((present_count.to_f / total_count) * 100).round(2)
      else
        @average_attendance_by_grade[grade.id] = 0
      end

      # Top 3 students by average result score in this grade
      @top_students_by_grade[grade.id] = students
        .select("students.*, AVG(results.score) AS avg_score")
        .joins(:results)
        .group("students.id")
        .order("avg_score DESC")
        .limit(3)

      # Average academic score for the grade
      avg_score = students.joins(:results).average(:score) || 0
      @average_score_by_grade[grade.id] = avg_score.round(2)

      # Top 3 classes by average student score in this grade
      @top_classes_by_grade[grade.id] = grade.classrooms
        .joins(students: :results)
        .select("classrooms.*, AVG(results.score) AS avg_score")
        .group("classrooms.id")
        .order("avg_score DESC")
        .limit(1)
    end

    # Revenue calculations
    @expected_monthly_revenue = monthly_fee * total_students

    start_month = Date.today.beginning_of_month
    end_month = Date.today.end_of_month
    @actual_monthly_revenue = Payment.where(payment_date: start_month..end_month, paid: true).sum(:amount)

    @expected_yearly_revenue = @expected_monthly_revenue * 12

    start_year = Date.today.beginning_of_year
    end_year = Date.today.end_of_year
    @actual_yearly_revenue = Payment.where(payment_date: start_year..end_year, paid: true).sum(:amount)

    @variance_monthly = @actual_monthly_revenue - @expected_monthly_revenue
    @variance_yearly = @actual_yearly_revenue - @expected_yearly_revenue
  end
end
