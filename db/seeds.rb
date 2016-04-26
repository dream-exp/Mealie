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

Menu.create(:name => '焼き肉', :price => 980, :imageurl => "http://dream-exp.net/develop/mealie/images/yakiniku.jpg", :cal => 1200, :allergy => "適当,に,入れる", :quantity => 29, :day => "月火水金")
Menu.create(:name => '馬刺し', :price => 1200, :imageurl => "http://dream-exp.net/develop/mealie/images/yakiniku.jpg", :cal => 1000, :allergy => "適当,に,入れる", :quantity => 29, :day => "月金")