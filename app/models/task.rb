class Task < ApplicationRecord
  belongs_to :batch
  belongs_to :trainee, class_name: 'User', foreign_key: 'user_id'
  belongs_to :trainer, class_name: 'User', foreign_key: 'trainer_id'

  validates :name, :description, :deadline, presence: true
end
