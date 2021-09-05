class Dislike < ApplicationRecord
  belongs_to :user
  belongs_to :article, optional: true
  belongs_to :comment, optional: true

  validates :user_id, uniqueness: {scope: :article_id, :comment_id}
end
