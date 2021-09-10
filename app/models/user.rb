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
  has_many :favorites, foreign_key: :article_id, class_name: 'UserArticle'


  has_many :followers, foreign_key: :follower_id, class_name: "Friendship"
  has_many :followed, through: :followers
  has_many :followed, foreign_key: :followed_id, class_name: "Friendship"
  has_many :followers, through: :followed

  validates :username, presence: true, length: { maximum: 25, too_long: "may not exceed %{count} characters" }

  def add_favorite(article)
    if self.favorites.where(id: article.id).empty?
      UserArticle.create(user: self, article: article)
    end
  end
end
