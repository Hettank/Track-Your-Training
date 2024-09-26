class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :course
  # belongs_to :batch

  belongs_to :parent, class_name: 'Comment', optional: true, dependent: :destroy
  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy

  validates :body, presence: true
end
