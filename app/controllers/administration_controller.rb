class AdministrationController < ApplicationController

	def index
		@orders = Order.where(student_number: params[:student_number]).where(created_at: Time.now.all_day).where(:status => '注文確定').reverse_order
		@student_number = params[:student_number]
		render 'administration/index'
	end

	def statistics
		day = Date.today
		@orders = Order.all.reverse_order
		@data = {(day-13).strftime("%m月%d日").to_s => Order.where(created_at: 13.day.ago.all_day).count,(day-12).strftime("%m月%d日").to_s => Order.where(created_at: 12.day.ago.all_day).count,(day-11).strftime("%m月%d日").to_s => Order.where(created_at: 11.day.ago.all_day).count,(day-10).strftime("%m月%d日").to_s => Order.where(created_at: 10.day.ago.all_day).count,(day-9).strftime("%m月%d日").to_s => Order.where(created_at: 9.day.ago.all_day).count,(day-8).strftime("%m月%d日").to_s => Order.where(created_at: 8.day.ago.all_day).count,(day-7).strftime("%m月%d日").to_s => Order.where(created_at: 7.day.ago.all_day).count,(day-6).strftime("%m月%d日").to_s => Order.where(created_at: 6.day.ago.all_day).count, (day-5).strftime("%m月%d日").to_s => Order.where(created_at: 5.day.ago.all_day).count, (day-4).strftime("%m月%d日").to_s => Order.where(created_at: 4.day.ago.all_day).count, (day-3).strftime("%m月%d日").to_s => Order.where(created_at: 3.day.ago.all_day).count, (day-2).strftime("%m月%d日").to_s => Order.where(created_at: 2.day.ago.all_day).count, (day-1).strftime("%m月%d日").to_s => Order.where(created_at: 1.day.ago.all_day).count, (day).strftime("%m月%d日").to_s => Order.where(created_at: 0.day.ago.all_day).count}
		render 'administration/statistics'
	end
end
