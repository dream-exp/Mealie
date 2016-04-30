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

Menu.create(:name => '焼き肉', :price => 3240, :category => "肉類", :imageurl => "yakiniku.jpg", :cal => 1100, :allergy => "なし", :quantity => 29, :day => "月火水金")
Menu.create(:name => '馬刺し', :price => 834, :category => "肉類", :imageurl => "dummy/dream_exp_2015-10月-12.jpg", :cal => 800, :allergy => "なし", :quantity => 10, :day => "月火水木")
Menu.create(:name => 'きしめん', :price => 450, :category => "麺類", :imageurl => "dummy/dream_exp_2015-10月-13.jpg", :cal => 700, :allergy => "小麦", :quantity => 15, :day => "月火水")
Menu.create(:name => '回転すしのまぐろ', :price => 450, :category => "寿司", :imageurl => "dummy/dream_exp_2015-12月-18.jpg", :cal => 100, :allergy => "なし", :quantity => 12, :day => "月")
Menu.create(:name => '鶏魚貝海鮮塩拉', :price => 650, :category => "麺類", :imageurl => "dummy/dream_exp_2016-2月-05.jpg", :cal => 900, :allergy => "小麦", :quantity => 5, :day => "水")
Menu.create(:name => 'Cafe crowd ランチ', :price => 1300, :category => "定食", :imageurl => "dummy/dream_exp_2016-2月-08.jpg", :cal => 1000, :allergy => "卵", :quantity => 20, :day => "木金")
Menu.create(:name => '天下一品 こってり', :price => 650, :category => "麺類", :imageurl => "dummy/dream_exp_2016-2月-10.jpg", :cal => 1200, :allergy => "鶏", :quantity => 20, :day => "火")
Menu.create(:name => '牛タン朝定食', :price => 480, :category => "定食", :imageurl => "dummy/dream_exp_2016-4月-10.jpg", :cal => 700, :allergy => "牛", :quantity => 5, :day => "金")

User.create(:student_number => 12209, :card_id => "1145141919810", :orderarray => ["aaaaa", "bbbbb"], :not_pay => 810)
User.create(:student_number => 12210, :card_id => "1145141919893", :orderarray => ["ccccc", "ddddd"], :not_pay => 893)

Order.create(:student_number => 12209, :menu_id => 2, :menu_name => '焼き肉', :price => 3240, :status => '予約受付')
Order.create(:student_number => 12209, :menu_id => 4,  :menu_name => '馬刺し', :price => 834, :status => '支払い済み')
Order.create(:student_number => 12210, :menu_id => 1, :menu_name => '牛タン朝定食', :price => 480, :status => '予約受付')