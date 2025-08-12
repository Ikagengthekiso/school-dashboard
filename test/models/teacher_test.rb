class Teacher < ApplicationRecord
  has_many :lectures
  has_many :classrooms, foreign_key: 'homeroom_teacher_id'
  
  def full_name
    "#{first_name} #{last_name}"
  end
end
