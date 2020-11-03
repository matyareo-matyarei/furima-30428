class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は英字と数字の両方を含めてください'

  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :family_name, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'は全角で入力してください' }
    validates :first_name, format:  { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'は全角で入力してください' }
    validates :family_kana, format: { with: /\A[ァ-ン]+\z/, message: 'は全角カナで入力してください' }
    validates :first_kana, format:  { with: /\A[ァ-ン]+\z/, message: 'は全角カナで入力してください' }
  end

  has_many :items
  has_many :orders
  has_one :card, dependent: :destroy

end
