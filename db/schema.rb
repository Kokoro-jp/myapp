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

ActiveRecord::Schema.define(version: 20_230_108_112_915) do
  create_table 'favorites', charset: 'utf8mb4', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'post_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['post_id'], name: 'index_favorites_on_post_id'
    t.index %w[user_id post_id], name: 'index_favorites_on_user_id_and_post_id', unique: true
    t.index ['user_id'], name: 'index_favorites_on_user_id'
  end

  create_table 'impressions', charset: 'utf8mb4', force: :cascade do |t|
    t.string 'impressionable_type'
    t.integer 'impressionable_id'
    t.integer 'user_id'
    t.string 'controller_name'
    t.string 'action_name'
    t.string 'view_name'
    t.string 'request_hash'
    t.string 'ip_address'
    t.string 'session_hash'
    t.text 'message'
    t.text 'referrer'
    t.text 'params'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[controller_name action_name ip_address], name: 'controlleraction_ip_index'
    t.index %w[controller_name action_name request_hash], name: 'controlleraction_request_index'
    t.index %w[controller_name action_name session_hash], name: 'controlleraction_session_index'
    t.index %w[impressionable_type impressionable_id ip_address], name: 'poly_ip_index'
    t.index %w[impressionable_type impressionable_id params], name: 'poly_params_request_index',
                                                              length: { params: 255 }
    t.index %w[impressionable_type impressionable_id request_hash], name: 'poly_request_index'
    t.index %w[impressionable_type impressionable_id session_hash], name: 'poly_session_index'
    t.index %w[impressionable_type message impressionable_id], name: 'impressionable_type_message_index',
                                                               length: { message: 255 }
    t.index ['user_id'], name: 'index_impressions_on_user_id'
  end

  create_table 'posts', charset: 'utf8mb4', force: :cascade do |t|
    t.string 'product_img'
    t.string 'product_introduction'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'store_id'
    t.integer 'impressions_count', default: 0
    t.index ['store_id'], name: 'index_posts_on_store_id'
  end

  create_table 'stores', charset: 'utf8mb4', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'store_name'
    t.string 'store_address'
    t.string 'business_hours'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.float 'latitude'
    t.float 'longitude'
    t.index ['email'], name: 'index_stores_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_stores_on_reset_password_token', unique: true
  end

  create_table 'users', charset: 'utf8mb4', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'user_name', default: '', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'favorites', 'posts'
  add_foreign_key 'favorites', 'users'
  add_foreign_key 'posts', 'stores'
end
