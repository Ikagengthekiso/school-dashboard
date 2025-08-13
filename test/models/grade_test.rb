class Grade < ApplicationRecord
  has_many :classrooms
  has_many :students
end
