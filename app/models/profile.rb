class Profile < ApplicationRecord
  belongs_to :user
  has_many :posts
  has_many :comments

  has_many :likes, foreign_key: 'profile_like_id'
  has_many :liked_posts, through: :likes
end
