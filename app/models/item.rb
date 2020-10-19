class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :image, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category, :status, :burden, :area, :schedule

  #空の投稿を保存できないようにする
  validates :name, :descriptions, :category, :status, :burden, :area, :schedule, :price, presence: true

  #ジャンルの選択が「--」の時は保存できないようにする(genre_idのid:1以外が保存できる)
  validates :category_id, numericality: { other_than: 1 } 
  validates :status_id, numericality: { other_than: 1 } 
  validates :burden_id, numericality: { other_than: 1 } 
  validates :area_id, numericality: { other_than: 1 } 
  validates :schedule_id, numericality: { other_than: 1 } 

end
