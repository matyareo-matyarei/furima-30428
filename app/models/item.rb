class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :image, presence: true
  with_options presence: true do
    validates :name
    validates :descriptions
    validates :category_id
    validates :status_id
    validates :burden_id
    validates :area_id
    validates :date_id
    validates :price
  end
end
