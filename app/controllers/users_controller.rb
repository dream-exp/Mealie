class UsersController < ApplicationController

	def index
		@user = User.where(student_number: params[:student_number])
		@order = Order.where(student_number: params[:student_number]).where(created_at: Time.now.all_day).reverse_order
		render 'users/index'
	end

	def tray
		@user = User.where(student_number: params[:student_number])
		@order = Order.where(student_number: params[:student_number]).where(created_at: Time.now.all_day).where(:status => 'トレー上').reverse_order
		render 'users/tray'
	end

	def past_order
		@user = User.where(student_number: params[:student_number])
		@order = Order.where(student_number: params[:student_number]).reverse_order
		render 'users/past_order'
	end

end
