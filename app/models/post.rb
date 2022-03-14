class Post < ApplicationRecord
  belongs_to :profile
  has_many :comments, dependent: :destroy

  has_many :likes, foreign_key: 'liked_post_id', dependent: :destroy
  has_many :profile_likes, through: :likes, dependent: :destroy
end
