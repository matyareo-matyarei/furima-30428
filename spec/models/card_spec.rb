require 'rails_helper'

RSpec.describe Card, type: :model do
  before do
    @card = FactoryBot.build(:card)

  end

  describe 'クレジットカード情報の保存' do
    context 'カード登録ができる場合' do
      it 'card_tokenとcustomer_tokenが入っていれば登録できる' do
        expect(@card).to be_valid
      end
    end

    context 'カード登録ができない場合' do
      it 'card_tokenが空だと登録できない' do
        @card.card_token = nil
        @card.valid?
        expect(@card.errors.full_messages).to include("正しくカード情報を入力してください")
      end

      it 'customer_tokenが空だと登録できない' do
        @card.customer_token = nil
        @card.valid?
        expect(@card.errors.full_messages).to include("正しくカード情報を入力してください")
      end
    end
  end
end