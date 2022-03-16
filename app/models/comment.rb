class Comment < ApplicationRecord
  belongs_to :profile
  belongs_to :post

  validates :username, presence: true
  validates :content, presence: true,
            length: {minimum: 4}
end
