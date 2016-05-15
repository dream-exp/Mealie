class OrdersController < ApplicationController

  def new
    @order = Order.new({:student_number => ActiveUser.first.student_number, :menu_id => params[:id], :menu_name => Menu.find(params[:id]).name, :price => Menu.find(params[:id]).price, :status => 'トレー上'})
    @order.save
    @menu = Menu.find(params[:id])
    Menu.find(params[:id]).update({:quantity => @menu.quantity - 1})
    redirect_to controller: 'menus', action: 'index'
  end

  def confirm
    @orders = Order.where(student_number: params[:student_number]).where(created_at: Time.now.all_day).where(status: 'トレー上')
    @orders.each do |order|
      order.update({:status => '予約注文完了'})
      @menu = Menu.find(order.menu_id)
      Menu.find(order.menu_id).update({:purchase_count => @menu.purchase_count + 1})
    end
    redirect_to controller: 'menus', action: 'index'
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @menu = Menu.find(@order.menu_id)
    Menu.find(@order.menu_id).update({:quantity => @menu.quantity + 1})
    @order.destroy
    if params[:from] == 'tray'
      redirect_to controller: 'users', action: 'tray', student_number: ActiveUser.first.student_number
    else
      redirect_to controller: 'users', action: 'index', student_number: ActiveUser.first.student_number
    end
  end

  def destroyall
    @orders = Order.where(student_number: params[:student_number]).where(created_at: Time.now.all_day).where(status: 'トレー上')
    @orders.each do |order|
      @menu = Menu.find(order.menu_id)
      Menu.find(order.menu_id).update({:quantity => @menu.quantity + 1})
      order.destroy
    end
    redirect_to controller: 'menus', action: 'index', student_number: ActiveUser.first.student_number
  end

end
