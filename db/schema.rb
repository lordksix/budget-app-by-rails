# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_230_912_012_432) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'groups', force: :cascade do |t|
    t.string 'name'
    t.string 'icon'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_groups_on_user_id'
  end

  create_table 'groups_spendings', id: false, force: :cascade do |t|
    t.bigint 'group_id'
    t.bigint 'spending_id'
    t.index ['group_id'], name: 'index_groups_spendings_on_group_id'
    t.index ['spending_id'], name: 'index_groups_spendings_on_spending_id'
  end

  create_table 'spendings', force: :cascade do |t|
    t.string 'name'
    t.string 'icon'
    t.bigint 'author_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['author_id'], name: 'index_spendings_on_author_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'groups', 'users'
  add_foreign_key 'spendings', 'users', column: 'author_id'
end
