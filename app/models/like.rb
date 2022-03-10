class Like < ApplicationRecord
  belongs_to :profile_like, class_name: 'Profile'
  belongs_to :liked_post, class_name: 'Post'
end
