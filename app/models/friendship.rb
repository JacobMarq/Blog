class Friendship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :user_id, uniqueness: {scope: :follower_id, :followed_id}
end
