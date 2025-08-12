class Classroom < ApplicationRecord
  belongs_to :grade
  belongs_to :homeroom_teacher, class_name: 'Teacher'
  has_many :students
  has_many :lectures
end
