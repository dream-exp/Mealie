# set :environment, Rails.env
# require File.expand_path(File.dirname(__FILE__) + "./environment.rb")

every 1.minute do
	command "echo 'reset'"
  runner "Menu.reset"
end