require 'faker'

# Clean old data in correct order
Payment.delete_all
Attendance.delete_all
Result.delete_all
Lecture.delete_all
Student.delete_all
Classroom.delete_all
Teacher.delete_all
Subject.delete_all
Grade.delete_all


grades = Grade.create!([
  { name: 'Grade 8' },
  { name: 'Grade 9' },
  { name: 'Grade 10' },
  { name: 'Grade 11' },
  { name: 'Grade 12' }
])


subjects = Subject.create!([
  { name: 'Physics' },
  { name: 'Chemistry' },
  { name: 'Mathematics' },
  { name: 'Mathematical Literacy' },
  { name: 'AP Mathematics' },
  { name: 'History' },
  { name: 'Geography' },
  { name: 'English' },
  { name: 'Afrikaans' },
  { name: 'Information Technology' },
  { name: 'Life Orientation' },
  { name: 'CAT' },
  { name: 'Engineering Graphics Design' },
  { name: 'Consumer Studies' },
  { name: 'Business Studies' }
])

subject_map = subjects.index_by(&:name)


total_classrooms = grades.size * 3
teachers = total_classrooms.times.map do |i|
  Teacher.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email
  )
end

# Assign subjects to teachers simply:
teachers.each_with_index do |teacher, idx|
  case idx
  when 0
    # Teacher 0 teaches Maths, Maths Lit, AP Math (assign Mathematics for simplicity)
    teacher.subjects << subject_map['Mathematics']
  when 1
    # Teacher 1 teaches Physics and Chemistry (assign Physics)
    teacher.subjects << subject_map['Physics']
  when 2
    # Teacher 2 teaches History and Geography (assign History)
    teacher.subjects << subject_map['History']
  else
    # Everyone else gets one random subject
    teacher.subjects << subjects.sample
  end
end

# Create classrooms per grade, assign homeroom teachers
classroom_names = [ 'A', 'B', 'C' ]
classrooms = []

grades.each_with_index do |grade, grade_index|
  classroom_names.each_with_index do |name, class_index|
    teacher_index = grade_index * 3 + class_index
    classrooms << Classroom.create!(
      grade: grade,
      name: name,
      homeroom_teacher: teachers[teacher_index]
    )
  end
end

# Create students and assign to classrooms randomly
students = []
grades.each do |grade|
  (20..30).to_a.sample.times do
    classroom = classrooms.select { |c| c.grade_id == grade.id }.sample
    students << Student.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      student_number: "PTA#{SecureRandom.hex(4).upcase}",
      grade: grade,
      classroom: classroom
    )
  end
end

# Create lectures only if teacher teaches the subject
grades.each do |grade|
  subjects.each do |subject|
    classrooms.select { |c| c.grade_id == grade.id }.each do |classroom|
      teachers_for_subject = teachers.select { |t| t.subjects.include?(subject) }
      next if teachers_for_subject.empty?
      teacher = teachers_for_subject.sample
      Lecture.create!(
        subject: subject,
        teacher: teacher,
        grade: grade,
        classroom: classroom,
        date: Faker::Date.backward(days: 30)
      )
    end
  end
end

# Create attendance records for students (last 30 days)
students.each do |student|
  (Date.today - 30.days..Date.today).each do |date|
    Attendance.create!(
      student: student,
      date: date,
      present: [ true, true, true, false ].sample  # mostly present
    )
  end
end

# Create results for each student and subject
students.each do |student|
  subjects.each do |subject|
    Result.create!(
      student: student,
      subject: subject,
      score: rand(50..100)
    )
  end
end

# Create payments for students (last 12 months)
students.each do |student|
  (0..11).each do |month_ago|
    Payment.create!(
      student: student,
      amount: 5300,
      payment_date: Date.today.beginning_of_month - month_ago.months,
      paid: [ true, true, true, false ].sample
    )
  end
end

puts "✅ Seeded #{grades.count} grades, #{teachers.count} teachers, #{classrooms.count} classrooms, and #{students.count} students."
