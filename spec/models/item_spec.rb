require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品登録' do
    it '商品画像、商品名、商品説明、カテゴリー情報、商品の状態、配料の負担、配送元の地域、配送までの日数、価格が入っていれば出品登できる' do
      expect(@item).to be_valid
    end
    it 'imageが無いと登録できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end
    it 'nameが空だと登録できない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end
    it 'descriptionsが空だと登録できない' do
      @item.descriptions = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Descriptions can't be blank")
    end
    it 'category_idが選択されていないと登録できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Category Select')
    end
    it 'status_idが選択されていないと登録できない' do
      @item.status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Status Select')
    end
    it 'burden_idが選択されていないと登録できない' do
      @item.burden_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Burden Select')
    end
    it 'area_idが選択されていないと登録できない' do
      @item.area_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Area Select')
    end
    it 'schedule_idが選択されていないと登録できない' do
      @item.schedule_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Schedule Select')
    end
    it 'priceが空だと登録できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end
    it 'priceは¥300~¥9,999,999の間でないと登録できない' do
      @item.price = 200
      @item.valid?
      expect(@item.errors.full_messages).to include('Price Out of setting range')
    end
    it 'priceは半角数字のみ登録できる' do
      @item.price = '３００'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price Half-width number')
    end
  end
end
