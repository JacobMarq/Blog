class Friendship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :follows, class_name: "User"

  validates :id, uniqueness: { scope: :follower }
  validates :id, uniqueness: { scope: :follows }
end
