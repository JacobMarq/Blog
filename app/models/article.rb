class Article < ApplicationRecord
    include Visible
    belongs_to :user, optional: true
    has_many :comments
    has_many :favorited, through: :user_articles, class_name: "User"
    has_one_attached :cover
    has_many :likes
    has_many :dislikes  

    validates :title, presence: true, length: { maximum: 40, too_long: "may not exceed %{count} characters" }
    validates :body, presence: true, length: { minimum: 10, too_short: "must contain atleast %{count} characters", maximum: 500 , too_long: "may not exceed %{count} characters"}

    # meant to be a ranking method but currently returns first three posted
    
    def liked?(user)
        !!self.likes.find{|like| like.user_id == user.id}
    end

    def disliked?(user)
        !!self.dislikes.find{|dislike| like.user_id == user.id}
    end
    
    def self.top_three(articles)
        # scores = []

        # articles.each do |article|
        #     scores << score(article)  
        # end



        # return 

        articles.sort_by(&:id)
        return articles[0..2]
    end

    def self.order_by(articles)
        
    end

    private
        # def score(article)
        #     l = article.likes.length
        #     d = article.dislikes.length

        #     s = l  d
        # end
end
