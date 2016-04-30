class Order < ActiveRecord::Base

	# scope :ordered_today, -> { where(created_at: Time.zone.now.all_day) }

end