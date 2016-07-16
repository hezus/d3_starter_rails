# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160716092511) do

  create_table "skills", force: :cascade do |t|
    t.string   "description"
    t.string   "category"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "skills_trainees", id: false, force: :cascade do |t|
    t.integer "skill_id"
    t.integer "trainee_id"
    t.index ["skill_id"], name: "index_skills_trainees_on_skill_id"
    t.index ["trainee_id"], name: "index_skills_trainees_on_trainee_id"
  end

  create_table "trainees", force: :cascade do |t|
    t.string   "name"
    t.string   "gender"
    t.integer  "age"
    t.integer  "distance"
    t.string   "job_category"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
