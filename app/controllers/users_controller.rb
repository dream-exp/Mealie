class UsersController < ApplicationController

	def index
		@user = User.where(student_number: params[:student_number])
		@order = Order.where(student_number: params[:student_number]).where(created_at: Time.zone.now.all_day)
		render 'users/index'
	end

	def tray
		@user = User.where(student_number: params[:student_number])
		@order = Order.where(student_number: params[:student_number]).where(created_at: Time.zone.now.all_day).where(:status => '予約受付')
		render 'users/tray'
	end



end
