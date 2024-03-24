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

ActiveRecord::Schema[7.1].define(version: 2024_03_24_154028) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

  create_table "active_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.string "remember_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["remember_token"], name: "index_active_sessions_on_remember_token", unique: true
    t.index ["user_id"], name: "index_active_sessions_on_user_id"
  end

  create_table "endpoints", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.string "request_path", null: false
    t.string "request_method", null: false
    t.integer "response_status_code", null: false
    t.text "response_body"
    t.text "response_headers"
    t.integer "delay_in_milliseconds"
    t.string "lookup_hash", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lookup_hash"], name: "index_endpoints_on_lookup_hash", unique: true
    t.index ["project_id"], name: "index_endpoints_on_project_id"
    t.index ["user_id"], name: "index_endpoints_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.bigint "endpoint_id", null: false
    t.string "url", null: false
    t.string "method", null: false
    t.text "body"
    t.text "headers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["endpoint_id"], name: "index_requests_on_endpoint_id"
    t.index ["project_id"], name: "index_requests_on_project_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "name"
    t.string "key"
    t.datetime "confirmed_at"
    t.string "unconfirmed_email"
    t.string "provider", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email", "provider"], name: "index_users_on_email_and_provider", unique: true
    t.index ["key"], name: "index_users_on_key", unique: true
  end

  add_foreign_key "active_sessions", "users", on_delete: :cascade
  add_foreign_key "endpoints", "projects"
  add_foreign_key "endpoints", "users"
  add_foreign_key "projects", "users", on_delete: :cascade
  add_foreign_key "requests", "endpoints"
  add_foreign_key "requests", "projects"
  add_foreign_key "requests", "users"
end
