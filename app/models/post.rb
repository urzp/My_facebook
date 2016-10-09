class Post < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :title, presence: true, length: { maximum: 140 }
  validates :content, presence: true
  validates :user_id, presence: true

  has_many :likes
  has_many :users_likes, through: :likes, source: :user

  has_many :comments
end
