class FriendshipRequest < ApplicationRecord
  belongs_to :invitee, class_name: 'Profile'
  belongs_to :inviter, class_name: 'Profile'
end
