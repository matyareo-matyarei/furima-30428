class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @item_order = ItemOrder.new
    @item = Item.find(params[:item_id])
    unless current_user.id == @item.user_id
    else
      redirect_to root_path
    end
  end

  def create
    @item_order = ItemOrder.new(order_params)
    @item = Item.find(params[:item_id])
    if @item_order.valid?
      @item_order.save
      return redirect_to root_path
    else
      render 'index'
    end
  end  
  
  private
  
  def order_params
    params.require(:item_order).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])

  end

end
