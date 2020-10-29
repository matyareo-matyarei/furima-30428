require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nickname,email,password,password_confirmation,family_name,first_name,family_kana,first_kana,birthdayが存在すれば登録できる' do
      expect(@user).to be_valid
    end

    it 'nicknameが空だと登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("ニックネームを入力してください")
    end

    it 'emailが空だと登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールを入力してください")
    end

    it 'emailが既に登録されているものと重複すると登録できない' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
    end

    it 'emailに＠を含んでいないと登録できない' do
      @user.email = 'aaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールは不正な値です')
    end

    it 'passwordが空だと登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください")
    end

    it 'passwordが６文字以上でないと登録できない' do
      @user.password = 'hoge1'
      @user.password_confirmation = 'hoge1'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end

    it 'passwordが半角英字のみでは登録できない' do
      @user.password = 'aaaaaa'
      @user.password_confirmation = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは英字と数字の両方を含めてください')
    end

    it 'passwordが半角数字のみでは登録できない' do
      @user.password = '000000'
      @user.password_confirmation = '000000'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは英字と数字の両方を含めてください')
    end

    it 'passwordとpassword_confirmationが一致しないと登録できない' do
      @user.password_confirmation = 'aaaaa1'
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end

    it 'ユーザー本名の名字が空だと登録できない' do
      @user.family_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("名字を入力してください")
    end

    it 'ユーザー本名の名前が空だと登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("名前を入力してください")
    end

    it 'ユーザー本名（名字）は、全角（漢字・ひらがな・カタカナ）での入力でないと登録できない' do
      @user.family_name = 'aaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('名字は全角で入力してください')
    end

    it 'ユーザー本名（名前）は、全角（漢字・ひらがな・カタカナ）での入力でないと登録できない' do
      @user.first_name = 'aaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前は全角で入力してください')
    end

    it 'ユーザー本名フリガナの名字が空だと登録できない' do
      @user.family_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("名字カナを入力してください")
    end

    it 'ユーザー本名フリガナの名前が空だと登録できない' do
      @user.first_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("名前カナを入力してください")
    end

    it 'ユーザー本名（名字）のフリガナは、全角（カタカナ）での入力でないと登録できない' do
      @user.family_kana = 'ひらがな'
      @user.valid?
      expect(@user.errors.full_messages).to include('名字カナは全角カナで入力してください')
    end

    it 'ユーザー本名（名前）のフリガナは、全角（カタカナ）での入力でないと登録できない' do
      @user.first_kana = 'ひらがな'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前カナは全角カナで入力してください')
    end

    it '生年月日が空だと登録できない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("生年月日を入力してください")
    end
  end
end
