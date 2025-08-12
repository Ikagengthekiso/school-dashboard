class AddCascadeDeleteToTeacherSubjects < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :teacher_subjects, :teachers
    add_foreign_key :teacher_subjects, :teachers, on_delete: :cascade
  end
end
