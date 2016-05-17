class AdministrationController < ApplicationController

	def index
		@orders = Order.where(student_number: params[:student_number]).where(created_at: Time.now.all_day).where(:status => '注文確定').reverse_order
		@student_number = params[:student_number]
		render 'administration/index'
	end

end
