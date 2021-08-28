class Comment < ApplicationRecord
  include Visible
  belongs_to :article
  belongs_to :subject, class_name: "Comment", optional: true

  has_many :replies, class_name: "Comment", foreign_key: "subject_id"

  validates :commenter, presence: true
  validates :body, presence: true, length: { minimum: 1, too_short: "must contain atleast %{count} characters", maximum: 200 , too_long: "may not exceed %{count} characters"}
end
