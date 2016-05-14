class Menu < ActiveRecord::Base
	mount_uploader :imageurl, ImageUploader
end
