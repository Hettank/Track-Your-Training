class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :created_courses, class_name: "Course", foreign_key: :user_id

  has_many :enrollments
  has_many :enrolled_courses, through: :enrollments, source: :course
  
  # Role methods
  def trainer?
    role == "trainer"
  end

  def admin?
    role == "admin"
  end

  def trainee?
    role == 'trainee'
  end

  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }
end
