# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130106071161) do

  create_table "authentify_sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "authentify_sessions", ["session_id"], :name => "index_authentify_sessions_on_session_id"
  add_index "authentify_sessions", ["updated_at"], :name => "index_authentify_sessions_on_updated_at"

  create_table "authentify_sys_action_on_tables", :force => true do |t|
    t.string   "action"
    t.string   "table_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "authentify_sys_action_on_tables", ["action"], :name => "index_authentify_sys_action_on_tables_on_action"
  add_index "authentify_sys_action_on_tables", ["table_name"], :name => "index_authentify_sys_action_on_tables_on_table_name"

  create_table "authentify_sys_logs", :force => true do |t|
    t.datetime "log_date"
    t.integer  "user_id"
    t.string   "user_name"
    t.string   "user_ip"
    t.string   "action_logged"
  end

  create_table "authentify_sys_module_mappings", :force => true do |t|
    t.integer  "sys_module_id"
    t.integer  "sys_user_group_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "authentify_sys_modules", :force => true do |t|
    t.string   "module_name"
    t.string   "module_group_name"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "authentify_sys_user_groups", :force => true do |t|
    t.string   "user_group_name"
    t.string   "short_note"
    t.integer  "user_type_code"
    t.string   "user_type_desp"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "zone"
  end

  create_table "authentify_sys_user_rights", :force => true do |t|
    t.integer  "sys_action_on_table_id"
    t.integer  "sys_user_group_id"
    t.string   "matching_column_name"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "accessible_col"
  end

  add_index "authentify_sys_user_rights", ["accessible_col"], :name => "index_authentify_sys_user_rights_on_accessible_col"
  add_index "authentify_sys_user_rights", ["sys_action_on_table_id"], :name => "index_authentify_sys_user_rights_on_sys_action_on_table_id"
  add_index "authentify_sys_user_rights", ["sys_user_group_id"], :name => "index_authentify_sys_user_rights_on_sys_user_group_id"

  create_table "authentify_user_levels", :force => true do |t|
    t.integer  "user_id"
    t.integer  "sys_user_group_id"
    t.integer  "manager_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "authentify_users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "login"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "status",                 :default => "active"
    t.integer  "last_updated_by_id"
    t.integer  "customer_id"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "customerx_customers", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "contact"
    t.string   "address"
    t.string   "country"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.string   "cell"
    t.integer  "sales_id"
    t.string   "web"
    t.integer  "category1_id"
    t.integer  "category2_id"
    t.boolean  "active",             :default => true
    t.string   "biz_status"
    t.integer  "last_updated_by_id"
    t.string   "quality_system"
    t.string   "employee_num"
    t.string   "revenue"
    t.text     "note"
    t.integer  "user_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.text     "custom_attributes"
  end

  create_table "manufacturers", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "web"
    t.boolean  "active",             :default => true
    t.integer  "last_updated_by_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "productx_emc_it_products", :force => true do |t|
    t.string   "name"
    t.string   "model"
    t.string   "drawing_num"
    t.text     "tech_spec"
    t.string   "work_voltage"
    t.string   "work_current"
    t.string   "frequency"
    t.string   "internal_frequency"
    t.integer  "rfq_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "quotex_quote_test_items", :force => true do |t|
    t.integer  "quote_id"
    t.integer  "test_item_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "quotex_quotes", :force => true do |t|
    t.integer  "rfq_id"
    t.decimal  "total",                  :precision => 8, :scale => 2
    t.integer  "discount",                                             :default => 0
    t.integer  "last_updated_by_id"
    t.boolean  "approved_by_dept_head"
    t.datetime "approve_date_dept_head"
    t.integer  "dept_head_id"
    t.boolean  "approved_by_corp_head"
    t.datetime "approve_date_corp_head"
    t.integer  "corp_head_id"
    t.boolean  "approved_by_customer"
    t.datetime "approve_date_custuomer"
    t.string   "customer_approver_name"
    t.text     "reason_for_reject"
    t.text     "note"
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.date     "quote_date"
  end

  create_table "rfqx_emc_categories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "last_updated_by_id"
    t.boolean  "active",             :default => true
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "rfqx_emc_rfq_standards", :force => true do |t|
    t.integer "rfq_id"
    t.integer "standard_id"
  end

  create_table "rfqx_emc_rfq_test_items", :force => true do |t|
    t.integer "rfq_id"
    t.integer "test_item_id"
  end

  create_table "rfqx_emc_rfqs", :force => true do |t|
    t.date     "rfq_date"
    t.integer  "product_id"
    t.integer  "sales_id"
    t.integer  "customer_id"
    t.integer  "safety_eng_id"
    t.integer  "emc_eng_id"
    t.integer  "last_updated_by_id"
    t.boolean  "active",             :default => true
    t.date     "start_date"
    t.date     "finish_date"
    t.boolean  "need_report",        :default => true
    t.string   "report_language"
    t.boolean  "top_secret",         :default => false
    t.integer  "category_id"
    t.string   "cust_contact_name"
    t.string   "cust_contact_phone"
    t.integer  "manufacturer_id"
    t.text     "note"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "standards", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "active",             :default => true
    t.integer  "last_updated_by_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "test_itemx_test_items", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.text     "description"
    t.integer  "standard_id"
    t.decimal  "rate",               :precision => 8, :scale => 2
    t.boolean  "active",                                           :default => true
    t.integer  "last_updated_by_id"
    t.boolean  "sub_lease",                                        :default => false
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
  end

  create_table "test_itemx_test_plan_logs", :force => true do |t|
    t.integer  "test_plan_id"
    t.text     "content"
    t.integer  "last_updated_by_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "test_itemx_test_plans", :force => true do |t|
    t.integer  "quote_id"
    t.date     "start_date"
    t.date     "finish_date"
    t.boolean  "cancelled",              :default => false
    t.boolean  "completed",              :default => false
    t.date     "actual_start_date"
    t.date     "actual_finish_date"
    t.boolean  "approved_by_dept_head"
    t.date     "approve_date_dept_head"
    t.integer  "dept_head_id"
    t.string   "reason_for_reject"
    t.integer  "last_updated_by_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.text     "sample_requirement"
    t.integer  "sample_qty"
    t.string   "unit"
  end

  create_table "test_itemx_test_samples", :force => true do |t|
    t.integer  "test_plan_id"
    t.string   "name"
    t.string   "desp"
    t.integer  "qty"
    t.string   "unit"
    t.string   "storage_location"
    t.date     "return_date"
    t.text     "periphral_requirement"
    t.integer  "manufacturer_id"
    t.string   "sample_doc"
    t.integer  "last_updated_by_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

end
