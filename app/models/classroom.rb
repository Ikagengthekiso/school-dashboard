
class Classroom < ApplicationRecord
  belongs_to :grade
  has_many :students
  belongs_to :homeroom_teacher, class_name: "Teacher"  
end