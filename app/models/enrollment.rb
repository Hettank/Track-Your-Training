class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  after_destroy :remove_user_from_batchs

  private

  def remove_user_from_batchs
    batches = course.batches.joins(:users).where(users: { id: user.id })

    batches.each do |batch|
      batch.users.delete(user)
    end
  end
end
