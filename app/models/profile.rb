class Profile < ApplicationRecord
  belongs_to :user
  has_many :posts
  has_many :comments

  has_many :likes, foreign_key: 'profile_like_id'
  has_many :liked_posts, through: :likes

  has_and_belongs_to_many :friends,
                          class_name: 'Profile',
                          foreign_key: 'this_profile_id',
                          association_foreign_key: 'other_profile_id'
end
