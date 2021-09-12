class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable

  has_one_attached :avi

  has_many :articles
  has_many :comments

  has_many :likes
  has_many :dislikes
  has_many :user_articles
  has_many :favorites, through: :user_articles, source: :article

  has_many :followers, foreign_key: :follows_id, class_name: "Friendship"
  has_many :follows, foreign_key: :follower_id, class_name: "Friendship"

  validates :username, presence: true, length: { maximum: 25, too_long: "may not exceed %{count} characters" }

  def followed?(user)
    !!self.followers.find{|friendship| friendship.follows_id == self.id && friendship.follower_id == user.id}
  end

  def select_friendship(user)
    friendship = !!self.followers.select{|friendship| return friendship if friendship.follows_id == self.id && friendship.follower_id == user.id}
    return friendship
  end
end
