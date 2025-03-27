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

ActiveRecord::Schema[7.1].define(version: 2025_03_27_165653) do
  create_table "assistants", force: :cascade do |t|
    t.boolean "terms_agreed", default: false
    t.date "date_of_birth"
    t.integer "department_id", null: false
    t.string "role", null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lunch_option"
    t.index ["department_id"], name: "index_assistants_on_department_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "features", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "assistant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assistant_id"], name: "index_features_on_assistant_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "assistant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assistant_id"], name: "index_tasks_on_assistant_id"
  end

  add_foreign_key "assistants", "departments"
  add_foreign_key "features", "assistants"
  add_foreign_key "tasks", "assistants"
end
