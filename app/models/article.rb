class Article < ApplicationRecord
    include Visible
    belongs_to :user, optional: true
    has_many :comments
    has_many :user_articles
    has_many :favorited, through: :user_articles, source: :user

    has_one_attached :cover
    has_many :likes
    has_many :dislikes  

    validates :title, presence: true, length: { maximum: 40, too_long: "may not exceed %{count} characters" }
    validates :body, presence: true, length: { minimum: 10, too_short: "must contain atleast %{count} characters", maximum: 500 , too_long: "may not exceed %{count} characters"}
    
    def favorited_by?(user)
        !!self.favorited.find{|favoriter| favoriter.id == user.id}
    end
    
    def liked?(user)
        !!self.likes.find{|like| like.user_id == user.id}
    end

    def select_user_like(user)
        like = !!self.likes.select{|like| return like if like.user_id == user.id}
    end

    def disliked?(user)
        !!self.dislikes.find{|dislike| dislike.user_id == user.id}
    end

    def select_user_dislike(user)
        dislike = !!self.dislikes.select{|dislike| return dislike if dislike.user_id == user.id}
    end
end
