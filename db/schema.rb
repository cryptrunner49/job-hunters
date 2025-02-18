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

ActiveRecord::Schema[8.0].define(version: 2025_02_18_103800) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "industry"
    t.string "location"
    t.string "github"
    t.string "website"
    t.string "job_search_website"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cover_letters", force: :cascade do |t|
    t.integer "hunter_id", null: false
    t.string "subject"
    t.text "latex_source"
    t.string "pdf_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hunter_id"], name: "index_cover_letters_on_hunter_id"
  end

  create_table "hunters", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "phone"
    t.index ["email_address"], name: "index_hunters_on_email_address", unique: true
  end

  create_table "interviews", force: :cascade do |t|
    t.integer "job_application_id", null: false
    t.datetime "scheduled_date"
    t.string "result"
    t.integer "mode"
    t.integer "interview_type"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_application_id"], name: "index_interviews_on_job_application_id"
  end

  create_table "job_applications", force: :cascade do |t|
    t.integer "hunter_id", null: false
    t.integer "job_post_id", null: false
    t.integer "resume_id", null: false
    t.integer "cover_letter_id", null: false
    t.string "status"
    t.string "phase"
    t.string "mail"
    t.datetime "applied_at"
    t.text "feedback"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cover_letter_id"], name: "index_job_applications_on_cover_letter_id"
    t.index ["hunter_id"], name: "index_job_applications_on_hunter_id"
    t.index ["job_post_id"], name: "index_job_applications_on_job_post_id"
    t.index ["resume_id"], name: "index_job_applications_on_resume_id"
  end

  create_table "job_offers", force: :cascade do |t|
    t.integer "hunter_id", null: false
    t.integer "job_post_id", null: false
    t.integer "company_id", null: false
    t.string "status"
    t.decimal "salary"
    t.date "start_date"
    t.date "offer_date"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_job_offers_on_company_id"
    t.index ["hunter_id"], name: "index_job_offers_on_hunter_id"
    t.index ["job_post_id"], name: "index_job_offers_on_job_post_id"
  end

  create_table "job_posts", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "skills_required"
    t.string "experience"
    t.string "location"
    t.boolean "relocation"
    t.boolean "apply_from_anywhere"
    t.integer "remote"
    t.integer "english_level"
    t.integer "japanese_level"
    t.decimal "salary"
    t.integer "employment_type"
    t.datetime "posted_at"
    t.datetime "closing_date"
    t.integer "company_id", null: false
    t.integer "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_job_posts_on_company_id"
    t.index ["role_id"], name: "index_job_posts_on_role_id"
  end

  create_table "resumes", force: :cascade do |t|
    t.integer "hunter_id", null: false
    t.string "title"
    t.text "latex_source"
    t.string "pdf_path"
    t.integer "resume_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hunter_id"], name: "index_resumes_on_hunter_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "hunter_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hunter_id"], name: "index_sessions_on_hunter_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cover_letters", "hunters"
  add_foreign_key "interviews", "job_applications"
  add_foreign_key "job_applications", "cover_letters"
  add_foreign_key "job_applications", "hunters"
  add_foreign_key "job_applications", "job_posts"
  add_foreign_key "job_applications", "resumes"
  add_foreign_key "job_offers", "companies"
  add_foreign_key "job_offers", "hunters"
  add_foreign_key "job_offers", "job_posts"
  add_foreign_key "job_posts", "companies"
  add_foreign_key "job_posts", "roles"
  add_foreign_key "resumes", "hunters"
  add_foreign_key "sessions", "hunters"
end
