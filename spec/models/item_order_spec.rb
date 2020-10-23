require 'rails_helper'

RSpec.describe ItemOrder, type: :model do
  before do
    @item_order = FactoryBot.build(:item_order)
  end

  it "postal_codeとprefecture_idとcityとaddressesとbuildingとphone_numberとtokenとnumberとexp_monthととexp_yearとcvcとtokenがあれば保存ができること" do
    expect(@item_order).to be_valid
  end

  it "postal_codeが空では登録できないこと" do
    @item_order.postal_code = nil
    @item_order.valid?
    expect(@item_order.errors.full_messages).to include("Postal code can't be blank")
  end

  it "postal_codeには-がないと登録できない" do
    @item_order.postal_code = '1234567'
    @item_order.valid?
    expect(@item_order.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
  end

  it "prefecture_idが選択されていないと登録できない" do
    @item_order.prefecture_id = 1
    @item_order.valid?
    expect(@item_order.errors.full_messages).to include("Prefecture Select")
  end

  it "cityが空では登録できない" do
    @item_order.city = nil
    @item_order.valid?
    expect(@item_order.errors.full_messages).to include("City can't be blank")
  end

  it "addressesが空では登録できない" do
    @item_order.addresses = nil
    @item_order.valid?
    expect(@item_order.errors.full_messages).to include("Addresses can't be blank")
  end
 
  it "phone_numberが空では登録できない" do
    @item_order.phone_number = nil
    @item_order.valid?
    expect(@item_order.errors.full_messages).to include("Phone number can't be blank")
  end

  it "phone_numberに-があると登録できない" do
    @item_order.phone_number = '03-123-4567'
    @item_order.valid?
    expect(@item_order.errors.full_messages).to include("Phone number Input only number")
  end

  it "phone_numberは11桁以内でないと登録できない" do
    @item_order.phone_number = '012345678901'
    @item_order.valid?
    expect(@item_order.errors.full_messages).to include("Phone number Input only number")
  end


  it "tokenが空では登録できない" do
    @item_order.token = nil
    @item_order.valid?
    expect(@item_order.errors.full_messages).to include("Token can't be blank")
  end


end
