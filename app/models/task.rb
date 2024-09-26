class Task < ApplicationRecord
  belongs_to :batch
  belongs_to :trainee, class_name: 'User', foreign_key: 'user_id'
  belongs_to :trainer, class_name: 'User', foreign_key: 'trainer_id', dependent: :destroy

  has_one_attached :resource, dependent: :destroy

  scope :filter_tasks, ->(status) { where.not(status: status)}

  validates :name, :description, :deadline, presence: true
end
