class Comment < ApplicationRecord
  include Visible
  belongs_to :article
  belongs_to :subject, class_name: "Comment", optional: true
  belongs_to :user, optional: true

  has_many :replies, class_name: "Comment", foreign_key: "subject_id"
  has_many :likes
  has_many :dislikes
  
  validates :commenter, presence: true
  validates :body, presence: true, length: { minimum: 1, too_short: "must contain atleast %{count} characters", maximum: 200 , too_long: "may not exceed %{count} characters"}

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
  
  def self.thread_length(comment)
    Comment.thread(comment).length
  end
  
  def self.thread(comment)
    return comment if comment.replies.nil?
    
    list = []
    queue = Queue.new

    comment.replies.each do |reply|
      queue << reply
    end

    until queue.empty?
      c = queue.pop
      list << c
      list << Comment.thread(c)
    end

    return list.flatten if queue.empty?
  end
end
