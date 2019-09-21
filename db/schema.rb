# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_190_921_133_133) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_admin_comments', force: :cascade do |t|
    t.string 'namespace'
    t.text 'body'
    t.string 'resource_type'
    t.bigint 'resource_id'
    t.string 'author_type'
    t.bigint 'author_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[author_type author_id], name: 'index_active_admin_comments_on_author_type_and_author_id'
    t.index ['namespace'], name: 'index_active_admin_comments_on_namespace'
    t.index %w[resource_type resource_id], name: 'index_active_admin_comments_on_resource_type_and_resource_id'
  end

  create_table 'admin_users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet 'current_sign_in_ip'
    t.inet 'last_sign_in_ip'
    t.index ['email'], name: 'index_admin_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admin_users_on_reset_password_token', unique: true
  end

  create_table 'balances', force: :cascade do |t|
    t.bigint 'tenant_id'
    t.float 'account_balance', default: 0.0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['tenant_id'], name: 'index_balances_on_tenant_id'
  end

  create_table 'billments', force: :cascade do |t|
    t.date 'date_done'
    t.bigint 'month_id'
    t.bigint 'admin_user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['admin_user_id'], name: 'index_billments_on_admin_user_id'
    t.index ['month_id'], name: 'index_billments_on_month_id'
  end

  create_table 'blocks', force: :cascade do |t|
    t.integer 'floor_id'
    t.integer 'number'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'credentials', force: :cascade do |t|
    t.integer 'name'
    t.integer 'int_value'
    t.string 'str_value'
    t.bigint 'admin_user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['admin_user_id'], name: 'index_credentials_on_admin_user_id'
  end

  create_table 'floors', force: :cascade do |t|
    t.integer 'side'
    t.integer 'number'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'months', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'payments', force: :cascade do |t|
    t.bigint 'balance_id'
    t.integer 'amount'
    t.date 'date_payed'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['balance_id'], name: 'index_payments_on_balance_id'
  end

  create_table 'ready_billings', force: :cascade do |t|
    t.bigint 'tenant_id'
    t.bigint 'balance_id'
    t.bigint 'billment_id'
    t.integer 'amount'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['balance_id'], name: 'index_ready_billings_on_balance_id'
    t.index ['billment_id'], name: 'index_ready_billings_on_billment_id'
    t.index ['tenant_id'], name: 'index_ready_billings_on_tenant_id'
  end

  create_table 'replenishments', force: :cascade do |t|
    t.bigint 'balance_id'
    t.integer 'amount'
    t.date 'replenishment_date'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'month_id'
    t.integer 'billment_id'
    t.index ['balance_id'], name: 'index_replenishments_on_balance_id'
  end

  create_table 'rooms', force: :cascade do |t|
    t.integer 'room_type'
    t.integer 'block_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'room_status', default: 0
    t.integer 'room_places'
  end

  create_table 'tenant_orders', force: :cascade do |t|
    t.bigint 'room_id'
    t.bigint 'tenant_id'
    t.date 'start_date'
    t.date 'end_date'
    t.integer 'order_status', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'count_places', default: 1
    t.index ['room_id'], name: 'index_tenant_orders_on_room_id'
    t.index ['tenant_id'], name: 'index_tenant_orders_on_tenant_id'
  end

  create_table 'tenants', force: :cascade do |t|
    t.string 'first_name'
    t.string 'surname'
    t.string 'last_name'
    t.string 'index'
    t.string 'region'
    t.string 'district'
    t.string 'city'
    t.string 'street'
    t.string 'house_number'
    t.string 'passport_series'
    t.string 'who_issued_the_passport'
    t.date 'when_issued_the_passport'
    t.string 'the_taxpayer_identification_number'
    t.string 'phone_number'
    t.string 'login_code'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id'
  end

  create_table 'tolk_locales', id: :serial, force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index ['name'], name: 'index_tolk_locales_on_name', unique: true
  end

  create_table 'tolk_phrases', id: :serial, force: :cascade do |t|
    t.text 'key'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'tolk_translations', id: :serial, force: :cascade do |t|
    t.integer 'phrase_id'
    t.integer 'locale_id'
    t.text 'text'
    t.text 'previous_text'
    t.boolean 'primary_updated', default: false
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index %w[phrase_id locale_id], name: 'index_tolk_translations_on_phrase_id_and_locale_id', unique: true
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet 'current_sign_in_ip'
    t.inet 'last_sign_in_ip'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'login_code'
    t.string 'first_name'
    t.string 'surname'
    t.string 'last_name'
    t.string 'index'
    t.string 'region'
    t.string 'district'
    t.string 'city'
    t.string 'street'
    t.string 'house_number'
    t.string 'passport_series'
    t.string 'who_issued_the_passport'
    t.date 'when_issued_the_passport'
    t.string 'the_taxpayer_identification_number'
    t.string 'phone_number'
    t.integer 'account_status', default: 0
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end
end
