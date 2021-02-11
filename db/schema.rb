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

ActiveRecord::Schema.define(version: 2021_02_11_155642) do

  create_table "answers", force: :cascade do |t|
    t.integer "approach_id", null: false
    t.integer "question_id", null: false
    t.text "value_serialized"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["approach_id", "question_id"], name: "index_answers_on_approach_id_and_question_id", unique: true
    t.index ["approach_id"], name: "index_answers_on_approach_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "answers_options", id: false, force: :cascade do |t|
    t.integer "answer_id", null: false
    t.integer "option_id", null: false
    t.index ["answer_id", "option_id"], name: "index_answers_options_on_answer_id_and_option_id"
  end

  create_table "approaches", force: :cascade do |t|
    t.integer "survey_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["survey_id"], name: "index_approaches_on_survey_id"
  end

  create_table "options", force: :cascade do |t|
    t.string "answer_text"
    t.string "position"
    t.integer "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_options_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "query"
    t.string "value_type", null: false
    t.boolean "required", default: false, null: false
    t.integer "max_characters", default: 0, null: false
    t.integer "position"
    t.integer "section_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_id"], name: "index_questions_on_section_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "survey_id", null: false
    t.integer "position"
    t.index ["survey_id"], name: "index_sections_on_survey_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "answers", "approaches"
  add_foreign_key "answers", "questions"
  add_foreign_key "approaches", "surveys"
  add_foreign_key "options", "questions"
  add_foreign_key "questions", "sections"
  add_foreign_key "sections", "surveys"
end
