class UserOder
  include ActiveModel::Model
  attr_accessor :number, :postal_code, :prefecture, :city, :addresses, :building, :phone_number

  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :family_name, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'Full-width characters' }
    validates :first_name, format:  { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'Full-width characters' }
    validates :family_kana, format: { with: /\A[ァ-ン]+\z/, message: 'Full-width katakana characters' }
    validates :first_kana, format:  { with: /\A[ァ-ン]+\z/, message: 'Full-width katakana characters' }
  end
  


end