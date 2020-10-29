class ItemOrder
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :item_id, :user_id, :token, :number, :cvc, :exp_month, :exp_year

  with_options presence: true do
    validates :token
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフン(-)を含めてください' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'を選んでください' }
    validates :city
    validates :addresses
    validates :phone_number, format: { with: /\A^[0-9]{,11}\z/, message: 'は半角数字のみ入力してください' }
  end

  def save  # フォームから送られてきたパラメーター情報をどのテーブルに保存するか
    # 購入の情報を保存し、「order」という変数に入れている
    order = Order.create(user_id: user_id, item_id: item_id)
    # 住所の情報を保存
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses, building: building, order_id: order.id)
  end
end
