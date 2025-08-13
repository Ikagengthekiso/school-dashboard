class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  primary_abstract_class
  has_many :teacher_subjects
  has_many :teachers, through: :teacher_subjects
end
