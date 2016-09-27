class PaymentsController < ApplicationController

	def index
		PaymentsUser.destroy_all
		render 'payments/index'
	end

	def payments_user_update
		unless PaymentsUser.exists?
			tweet = params[:student_number].to_s
      WebsocketRails[:payments].trigger "create", tweet
      PaymentsUser.create({:student_number => params[:student_number]})
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
    tweet = params[:student_number]
    WebsocketRails[:administration].trigger "create", tweet
		@sum = $sum
		render 'payments/pay'
	end
end
