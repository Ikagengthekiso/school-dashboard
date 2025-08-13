class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  has_many :teacher_subjects
  has_many :teachers, through: :teacher_subjects
end
