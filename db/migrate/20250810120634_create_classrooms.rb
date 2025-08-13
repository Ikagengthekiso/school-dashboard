class CreateClassrooms < ActiveRecord::Migration[6.1]
  def change
    create_table :classrooms do |t|
      t.string :name, null: false
      t.references :grade, null: false, foreign_key: true
      t.references :homeroom_teacher, null: false, foreign_key: { to_table: :teachers }

      t.timestamps
    end
  end
end
