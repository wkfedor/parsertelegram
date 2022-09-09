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

ActiveRecord::Schema[7.0].define(version: 2022_09_09_020507) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dopmygroups", force: :cascade do |t|
    t.string "countuser"
    t.string "comment"
    t.bigint "mygroup_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mygroup_id"], name: "index_dopmygroups_on_mygroup_id"
  end

  create_table "loadfiles", force: :cascade do |t|
    t.string "lfilename"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "maintext"
    t.text "user"
    t.text "img"
    t.integer "dopid"
    t.bigint "mygroup_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mygroup_id"], name: "index_messages_on_mygroup_id"
  end

  create_table "mygroups", force: :cascade do |t|
    t.bigint "iid"
    t.string "username"
    t.string "title"
    t.string "description"
    t.integer "countuser"
    t.datetime "datein"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "caption"
  end

  create_table "twoloadfiles", force: :cascade do |t|
    t.string "lfilename"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wfiles", force: :cascade do |t|
    t.string "word"
    t.string "flag"
    t.datetime "dateold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "fileid"
  end

  add_foreign_key "dopmygroups", "mygroups"
  add_foreign_key "messages", "mygroups"
end
