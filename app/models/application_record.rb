class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  has_many :teacher_subjects
  has_many :teachers, through: :teacher_subjects
end
