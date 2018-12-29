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

ActiveRecord::Schema.define(version: 20181229175330) do

  create_table "crop_types", force: :cascade do |t|
    t.string  "crop_name"
    t.integer "days_to_grow"
    t.integer "buy_price"
    t.string  "season"
    t.integer "sell_price"
  end

  create_table "farmers", force: :cascade do |t|
    t.string  "name"
    t.integer "day"
    t.string  "dog"
    t.string  "season"
    t.integer "money"
  end

  create_table "seed_bags", force: :cascade do |t|
    t.integer "farmer_id"
    t.integer "crop_type_id"
    t.integer "growth"
    t.integer "watered"
    t.integer "harvested"
    t.integer "planted"
    t.integer "ripe"
  end

end
