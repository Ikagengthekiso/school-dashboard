class CreateLectures < ActiveRecord::Migration[8.0]
  def change
    create_table :lectures do |t|
      t.references :subject, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: true
      t.references :grade, null: false, foreign_key: true
      t.references :classroom, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
