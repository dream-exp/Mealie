class OrdersController < ApplicationController

  def new
    @order = Order.new({:student_number => ActiveUser.first.student_number, :menu_id => params[:id], :menu_name => Menu.find(params[:id]).name, :price => Menu.find(params[:id]).price, :status => 'トレー上'})
    @order.save
    redirect_to controller: 'menus', action: 'index'
  end

  def confirm
    @orders = Order.where(student_number: params[:student_number]).where(created_at: Time.now.all_day).where(status: 'トレー上')
    @orders.each do |order|
      order.update({:status => '予約注文完了'})
    end
    redirect_to controller: 'menus', action: 'index'
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    if params[:action] == 'tray'
      redirect_to controller: 'users', action: 'tray', student_number: ActiveUser.first.student_number
    else
      redirect_to controller: 'users', action: 'index', student_number: ActiveUser.first.student_number
    end
  end

  def destroyall
    Order.where(student_number: params[:student_number]).where(created_at: Time.now.all_day).where(status: 'トレー上').destroy_all
    redirect_to controller: 'users', action: 'tray', student_number: ActiveUser.first.student_number
  end

end
