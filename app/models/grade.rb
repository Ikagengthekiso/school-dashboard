class Grade < ApplicationRecord
  has_many :classrooms, dependent: :destroy
  has_many :students, dependent: :destroy
end