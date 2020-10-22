class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])
    unless current_user.id == @item.user_id
      @order = Order.new
    else
      redirect_to root_path
    end
  end

  def create
    @order = Order.new(order_params)
    @item = Item.find(params[:item_id])
    if @order.valid?
      @order.save
      return redirect_to root_path
    else
      render 'index'
    end
  end  
  
  private
  
  def order_params
    params.permit(:item_id).merge(user_id: current_user.id,token: params[:token])
  end

end
