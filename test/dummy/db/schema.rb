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

ActiveRecord::Schema[7.1].define(version: 2025_04_01_134939) do
  create_table "assistants", force: :cascade do |t|
    t.boolean "terms_agreed", default: false
    t.date "date_of_birth"
    t.integer "age"
    t.string "colour"
    t.string "desired_filling"
    t.string "email"
    t.string "lunch_option"
    t.string "password"
    t.string "phone"
    t.string "title"
    t.string "website"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "department_id"
    t.integer "role_id"
    t.index ["department_id"], name: "index_assistants_on_department_id"
    t.index ["role_id"], name: "index_assistants_on_role_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "department_id", null: false
    t.string "email"
    t.string "password"
    t.integer "age"
    t.string "colour"
    t.date "date_of_birth"
    t.text "description"
    t.string "desired_filling"
    t.string "lunch_option"
    t.string "phone"
    t.boolean "terms_agreed", default: false
    t.string "website"
    t.integer "role_id", null: false
    t.index ["department_id"], name: "index_assistants_on_department_id"
    t.index ["role_id"], name: "index_assistants_on_role_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "assistants", "departments"
  add_foreign_key "assistants", "roles"
end
