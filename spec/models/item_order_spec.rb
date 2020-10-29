require 'rails_helper'

RSpec.describe ItemOrder, type: :model do
  before do
    @item_order = FactoryBot.build(:item_order)
  end

  describe '購入履歴の保存' do
    context '購入情報が保存できる場合' do
      it 'postal_codeとprefecture_idとcityとaddressesとbuildingとphone_numberとtokenとnumberとexp_monthととexp_yearとcvcとtokenがあれば保存ができること' do
        expect(@item_order).to be_valid
      end

      it 'buildingは空でも登録できる' do
        @item_order.building = nil
        expect(@item_order).to be_valid
      end
    end

    context '購入情報が保存できない場合' do
      it 'postal_codeが空では登録できないこと' do
        @item_order.postal_code = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("郵便番号を入力してください")
      end

      it 'postal_codeには-がないと登録できない' do
        @item_order.postal_code = '1234567'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include('郵便番号はハイフン(-)を含めてください')
      end

      it 'prefecture_idが選択されていないと登録できない' do
        @item_order.prefecture_id = 1
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include('都道府県を選んでください')
      end

      it 'cityが空では登録できない' do
        @item_order.city = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("市区町村を入力してください")
      end

      it 'addressesが空では登録できない' do
        @item_order.addresses = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("番地を入力してください")
      end

      it 'phone_numberが空では登録できない' do
        @item_order.phone_number = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("電話番号を入力してください")
      end

      it 'phone_numberに-があると登録できない' do
        @item_order.phone_number = '03-123-4567'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include('電話番号は半角数字のみ入力してください')
      end

      it 'phone_numberは11桁以内でないと登録できない' do
        @item_order.phone_number = '012345678901'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include('電話番号は半角数字のみ入力してください')
      end

      it 'tokenが空では登録できない' do
        @item_order.token = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("カード情報を入力してください")
      end
    end
  end
end
