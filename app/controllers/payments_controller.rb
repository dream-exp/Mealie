class PaymentsController < ApplicationController

	def index
		PaymentsUser.destroy_all
		render 'payments/index'
	end

	def payments_user_update
		if PaymentsUser.count == 0
      PaymentsUser.create({:student_number => params[:student_number]})
      tweet = params[:student_number].to_s
      WebsocketRails[:payments].trigger "create", tweet
      head :ok
    end
    render :nothing	=> true
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
