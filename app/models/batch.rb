class Batch < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user
  belongs_to :course
  # belongs_to :comment

  # has_and_belongs_to_many :users
  has_many :batch_users, dependent: :destroy
  has_many :users, through: :batch_users, dependent: :destroy
  # 

  validates :name, :description, :start_date, :end_date, :duration, presence: true
end
