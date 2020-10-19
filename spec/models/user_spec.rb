require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    it "nickname,email,password,password_confirmation,family_name,first_name,family_kana,first_kana,birthdayが存在すれば登録できる" do
      expect(@user).to be_valid
    end

    it "nicknameが空だと登録できない" do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it "emailが空だと登録できない" do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "emailが既に登録されているものと重複すると登録できない" do
      @user.save
      another_user = FactoryBot.build(:user, email:@user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end

    it "emailに＠を含んでいないと登録できない" do
      @user.email = "aaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it "passwordが空だと登録できない" do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "passwordが６文字以上でないと登録できない" do
      @user.password = "hoge1"
      @user.password_confirmation = "hoge1"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "passwordが半角英数字を混合していないと登録できない" do
      @user.password = "aaaaaa"
      @user.password_confirmation = "aaaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
    end

    it "passwordとpassword_confirmationが一致しないと登録できない" do
      @user.password_confirmation = "aaaaa1"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "ユーザー本名の名字が空だと登録できない" do
      @user.family_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name can't be blank")
    end

    it "ユーザー本名の名前が空だと登録できない" do
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力でないと登録できない" do
      @user.family_name = "aaa"
      @user.first_name = "aaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name Full-width characters","First name Full-width characters")
    end

    it "ユーザー本名フリガナの名字が空だと登録できない" do
      @user.family_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Family kana can't be blank")
    end

    it "ユーザー本名フリガナの名前が空だと登録できない" do
      @user.first_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First kana can't be blank")
    end

    it "ユーザー本名のフリガナは、全角（カタカナ）での入力でないと登録できない" do
      @user.family_kana = "ひらがな"
      @user.first_kana = "ひらがな"
      @user.valid?
      expect(@user.errors.full_messages).to include("Family kana Full-width katakana characters","First kana Full-width katakana characters")
    end

    it "生年月日が空だと登録できない" do
      @user.birthday = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
    
  end
end
