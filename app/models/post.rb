class Post < ApplicationRecord
  belongs_to :profile
  has_many :comments, dependent: :destroy

  has_many :likes, foreign_key: 'liked_post_id', dependent: :destroy
  has_many :profile_likes, through: :likes, dependent: :destroy

  validates :title, presence: true,
            length: {minimum: 5}
  validates :content, presence: true,
            length: {minimum: 25, maximum: 200}
end
