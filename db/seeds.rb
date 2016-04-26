# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# t.string :name
# t.integer :price
# t.string :imageurl
# t.integer :cal
# t.string :allergy
# t.integer :quantity
# t.string :day

Menu.create(:name => '焼き肉', :price => 3240, :imageurl => "yakiniku.jpg", :cal => 1100, :allergy => "なし", :quantity => 29, :day => "月火水金")
Menu.create(:name => '馬刺し', :price => 834, :imageurl => "dummy/dream_exp_2015-10月-12.jpg", :cal => 800, :allergy => "なし", :quantity => 10, :day => "月火水木")
Menu.create(:name => 'きしめん', :price => 450, :imageurl => "dummy/dream_exp_2015-10月-13.jpg", :cal => 700, :allergy => "小麦", :quantity => 15, :day => "月火水")
Menu.create(:name => 'まぐろ', :price => 450, :imageurl => "dummy/dream_exp_2015-12月-18.jpg", :cal => 100, :allergy => "なし", :quantity => 12, :day => "月")
Menu.create(:name => '鶏魚貝海鮮塩拉', :price => 650, :imageurl => "dummy/dream_exp_2016-2月-05.jpg", :cal => 900, :allergy => "小麦", :quantity => 5, :day => "水")
Menu.create(:name => 'Cafe crowd ランチ', :price => 1300, :imageurl => "dummy/dream_exp_2016-2月-08.jpg", :cal => 1000, :allergy => "卵", :quantity => 20, :day => "木金")
Menu.create(:name => '天下一品 こってり', :price => 650, :imageurl => "dummy/dream_exp_2016-2月-10.jpg", :cal => 1200, :allergy => "鶏", :quantity => 20, :day => "火")
Menu.create(:name => '牛タン朝定食', :price => 480, :imageurl => "dummy/dream_exp_2016-4月-10.jpg", :cal => 700, :allergy => "牛", :quantity => 5, :day => "金")

