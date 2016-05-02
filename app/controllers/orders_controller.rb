class OrdersController < ApplicationController

  def new
    @order = Order.new({:student_number => 12209, :menu_id => params[:id], :menu_name => Menu.find(params[:id]).name, :price => Menu.find(params[:id]).price, :status => '予約受付'})
    @order.save
    redirect_to controller: 'menus', action: 'index'
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to controller: 'users', action: 'index', student_number: 12209 #一時的に12209にしてある
  end

end
