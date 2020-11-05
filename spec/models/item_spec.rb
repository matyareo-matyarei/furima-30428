require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品登録' do
    it '商品画像、商品名、商品説明、カテゴリー情報、商品の状態、配料の負担、配送元の地域、配送までの日数、価格が入っていれば出品登できる' do
      expect(@item).to be_valid
    end
    it 'imagesが無いと登録できない' do
      @item.images = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("画像を入力してください")
    end
    it 'nameが空だと登録できない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("商品名を入力してください")
    end
    it 'descriptionsが空だと登録できない' do
      @item.descriptions = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("商品説明を入力してください")
    end
    it 'category_idが選択されていないと登録できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('カテゴリーを選んでください')
    end
    it 'status_idが選択されていないと登録できない' do
      @item.status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('商品の状態を選んでください')
    end
    it 'burden_idが選択されていないと登録できない' do
      @item.burden_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('配送料の負担を選んでください')
    end
    it 'area_idが選択されていないと登録できない' do
      @item.area_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('発送元の地域を選んでください')
    end
    it 'schedule_idが選択されていないと登録できない' do
      @item.schedule_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('発送までの日数を選んでください')
    end
    it 'priceが空だと登録できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("販売価格を入力してください")
    end
    it 'priceは¥300~¥9,999,999の間でないと登録できない' do
      @item.price = 200
      @item.valid?
      expect(@item.errors.full_messages).to include('販売価格は¥300〜9,999,999で設定してください')
    end
    it 'priceは全角数字だと登録できない' do
      @item.price = '３００'
      @item.valid?
      expect(@item.errors.full_messages).to include('販売価格は半角数字で入力してください')
    end
  end
end
