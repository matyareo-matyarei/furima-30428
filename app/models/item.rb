class Item < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_one :order

  validates :images, presence: true
  validates :price, numericality: { message: 'Half-width number' }
  validates_inclusion_of :price, in: 300..9_999_999, message: 'Out of setting range'

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :burden
  belongs_to_active_hash :area
  belongs_to_active_hash :schedule

  validates :name, :descriptions, :category, :status, :burden, :area, :schedule, :price, presence: true

  validates :category_id, numericality: { other_than: 1, message: 'Select' }
  validates :status_id, numericality: { other_than: 1, message: 'Select' }
  validates :burden_id, numericality: { other_than: 1, message: 'Select' }
  validates :area_id, numericality: { other_than: 1, message: 'Select' }
  validates :schedule_id, numericality: { other_than: 1, message: 'Select' }
end
