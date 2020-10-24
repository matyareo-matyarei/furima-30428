class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'Include both letters and numbers'

  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :family_name, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'Full-width characters' }
    validates :first_name, format:  { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'Full-width characters' }
    validates :family_kana, format: { with: /\A[ァ-ン]+\z/, message: 'Full-width katakana characters' }
    validates :first_kana, format:  { with: /\A[ァ-ン]+\z/, message: 'Full-width katakana characters' }
  end

  has_many :items
  has_many :orders
end
