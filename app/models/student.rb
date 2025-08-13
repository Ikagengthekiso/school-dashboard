
class Student < ApplicationRecord
  belongs_to :grade
  belongs_to :classroom
  has_many :results
  has_many :attendances
  has_many :payments
end
