class Course < ApplicationRecord
  # Associations users <==> courses
  belongs_to :trainer, class_name: "User", foreign_key: :user_id
  
  belongs_to :user

  has_many :enrollments
  has_many :trainees, through: :enrollments, source: :user

  has_one_attached :image

  validates :name, :duration, :description, :category, :level, :start_date, :end_date, presence: true
  validate :image_type_validation

  private

  def image_type_validation
    if image.attached? && !image.content_type.in?(%w(image/jpeg image/png))
      errors.add(:image, 'must be a JPEG or PNG')
    elsif image.attached? == false
      errors.add(:image, 'must be attached')
    end
  end
end