class Lecture < ApplicationRecord
  belongs_to :subject
  belongs_to :teacher
  belongs_to :grade
  belongs_to :classroom
  
end
