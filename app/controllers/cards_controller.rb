class CardsController < ApplicationController
  def new
    @card = Card.new
  end

  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer = Payjp::Customer.create(
    description: 'test',
    card: params[:token]
    )
    @card = Card.new( # トークン化されたカード情報を保存する
      card_token: params[:token], # カードトークン
      customer_token: customer.id, # 顧客トークン
      user_id: current_user.id # ログインしているユーザー
    )
    if @card.save
      redirect_to root_path
    else
      render :new # カード登録画面
    end
  end

  def show
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id) # ユーザーidを元に、カード情報取得

    customer = Payjp::Customer.retrieve(card.customer_token) # 先程のカード情報を元に、顧客情報を取得
    @card = customer.cards.first # 顧客の「最初のカード情報」を取得
  end

end
