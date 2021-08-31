class Article < ApplicationRecord
    include Visible
    has_many :comments
    has_one_attached :cover

    validates :title, presence: true
    validates :body, presence: true, length: { minimum: 10, too_short: "must contain atleast %{count} characters", maximum: 500 , too_long: "may not exceed %{count} characters"}

    # meant to be a ranking method but currently returns first three posted
    def self.top_three(articles)
        # scores = []

        # articles.each do |article|
        #     scores << score(article)  
        # end



        # return 

        articles.sort_by(&:id)
        return articles[0..2]
    end

    private
        # def score(article)
        #     l = article.likes.length
        #     d = article.dislikes.length

        #     s = l  d
        # end
end
