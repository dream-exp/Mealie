class PaymentsController < ApplicationController

	def index
		render 'payments/index'
	end

	def confirmation
		@order = Order.where(student_number: params[:student_number]).where(created_at: Time.now.all_day).where(:status => '予約注文完了').reverse_order
		@student_number = params[:student_number]
		render 'payments/confirmation'
	end

	def pay
		@orders = Order.where(student_number: params[:student_number]).where(created_at: Time.now.all_day).where(status: '予約注文完了')
    @orders.each do |order|
      order.update({:status => '注文確定'})
    end
		@sum = $sum
		render 'payments/pay'
	end
end
