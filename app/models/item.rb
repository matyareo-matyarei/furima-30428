class Item < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_one :order

  validates :images, presence: true
  validates :price, numericality: { message: 'は半角数字で入力してください' }
  validates_inclusion_of :price, in: 300..9_999_999, message: 'は¥300〜9,999,999で設定してください'

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :burden
  belongs_to_active_hash :area
  belongs_to_active_hash :schedule

  validates :name, :descriptions, :category, :status, :burden, :area, :schedule, :price, presence: true

  validates :category_id, numericality: { other_than: 1, message: 'を選んでください' }
  validates :status_id, numericality: { other_than: 1, message: 'を選んでください' }
  validates :burden_id, numericality: { other_than: 1, message: 'を選んでください' }
  validates :area_id, numericality: { other_than: 1, message: 'を選んでください' }
  validates :schedule_id, numericality: { other_than: 1, message: 'を選んでください' }
end
