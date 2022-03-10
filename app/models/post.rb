class Post < ApplicationRecord
  belongs_to :profile
  has_many :comments

  has_many :likes, foreign_key: 'liked_post_id'
  has_many :profile_likes, through: :likes
end
