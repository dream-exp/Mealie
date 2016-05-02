class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_tray_quantity
  	quantity = Order.where(student_number: params[:student_number]).where(created_at: Time.zone.now.all_day).where(status: '予約受付').count
  	return quantity
  end

end
