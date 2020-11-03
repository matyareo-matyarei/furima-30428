class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
    redirect_to new_card_path and return unless current_user.card.present?
    @item_order = ItemOrder.new
  end

  def create
    @item_order = ItemOrder.new(order_params)
    if @item_order.valid?
      pay_item
      @item_order.save
    else
      render 'index'
    end

  end

  private

  def order_params
    params.require(:item_order).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id, token: current_user.card.customer_token)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 秘密鍵の環境変数を読み込む
    customer_token = current_user.card.customer_token # ログインユーザーの顧客トークン定義
    Payjp::Charge.create(
      amount: @item[:price],         # 商品の値段
      customer: customer_token,      # 顧客のトークン
      currency: 'jpy'                # 通貨の種類（日本円）
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

end
