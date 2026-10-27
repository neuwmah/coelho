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

ActiveRecord::Schema[7.2].define(version: 2024_10_26_000007) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bios", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "headline", null: false
    t.text "summary", null: false
    t.string "location"
    t.json "skills", default: [], null: false
    t.string "avatar_url"
    t.string "resume_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "summary_mobile"
  end

  create_table "contact_channels", force: :cascade do |t|
    t.string "title", null: false
    t.string "subtitle", null: false
    t.string "icon", null: false
    t.string "href"
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position"], name: "index_contact_channels_on_position"
  end

  create_table "contact_messages", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.text "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_contact_messages_on_email"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "email", null: false
    t.string "phone"
    t.string "location", null: false
    t.string "linkedin_url"
    t.string "github_url"
    t.string "twitter_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "experiences", force: :cascade do |t|
    t.string "company", null: false
    t.string "role", null: false
    t.string "location"
    t.date "started_on", null: false
    t.date "ended_on"
    t.boolean "current", default: false, null: false
    t.text "description"
    t.json "highlights", default: [], null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["started_on"], name: "index_experiences_on_started_on"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug", null: false
    t.string "summary", null: false
    t.text "description"
    t.json "tech_stack", default: [], null: false
    t.string "repo_url"
    t.string "live_url"
    t.boolean "featured", default: false, null: false
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["featured"], name: "index_projects_on_featured"
    t.index ["position"], name: "index_projects_on_position"
    t.index ["slug"], name: "index_projects_on_slug", unique: true
  end
end
