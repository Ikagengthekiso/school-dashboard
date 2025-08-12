# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_08_11_172619) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.integer "student_id", null: false
    t.date "date"
    t.boolean "present"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_attendances_on_student_id"
  end

  create_table "classrooms", force: :cascade do |t|
    t.string "name", null: false
    t.integer "grade_id", null: false
    t.integer "homeroom_teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grade_id"], name: "index_classrooms_on_grade_id"
    t.index ["homeroom_teacher_id"], name: "index_classrooms_on_homeroom_teacher_id"
  end

  create_table "grades", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lectures", force: :cascade do |t|
    t.integer "subject_id", null: false
    t.integer "teacher_id", null: false
    t.integer "grade_id", null: false
    t.integer "classroom_id", null: false
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_lectures_on_classroom_id"
    t.index ["grade_id"], name: "index_lectures_on_grade_id"
    t.index ["subject_id"], name: "index_lectures_on_subject_id"
    t.index ["teacher_id"], name: "index_lectures_on_teacher_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "student_id", null: false
    t.decimal "amount"
    t.date "payment_date"
    t.boolean "paid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_payments_on_student_id"
  end

  create_table "results", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "subject_id", null: false
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_results_on_student_id"
    t.index ["subject_id"], name: "index_results_on_subject_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "student_number"
    t.integer "grade_id", null: false
    t.integer "classroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_students_on_classroom_id"
    t.index ["grade_id"], name: "index_students_on_grade_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teacher_subjects", force: :cascade do |t|
    t.integer "teacher_id", null: false
    t.integer "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_teacher_subjects_on_subject_id"
    t.index ["teacher_id"], name: "index_teacher_subjects_on_teacher_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "attendances", "students"
  add_foreign_key "classrooms", "grades"
  add_foreign_key "classrooms", "teachers", column: "homeroom_teacher_id"
  add_foreign_key "lectures", "classrooms"
  add_foreign_key "lectures", "grades"
  add_foreign_key "lectures", "subjects"
  add_foreign_key "lectures", "teachers"
  add_foreign_key "payments", "students"
  add_foreign_key "results", "students"
  add_foreign_key "results", "subjects"
  add_foreign_key "students", "classrooms"
  add_foreign_key "students", "grades"
  add_foreign_key "teacher_subjects", "subjects"
  add_foreign_key "teacher_subjects", "teachers"
end
