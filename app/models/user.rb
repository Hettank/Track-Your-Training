class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Automatically delete created courses when a user is deleted
  has_many :created_courses, class_name: "Course", foreign_key: :user_id, dependent: :destroy
  
  # Automatically delete enrollments when a user is deleted
  has_many :enrollments, dependent: :destroy
  has_many :enrolled_courses, through: :enrollments, source: :course

  # Associations for comment section
  has_many :comments, dependent: :destroy

  # Associations for batch through BatchUser join model
  has_many :batch_users
  has_many :batches, through: :batch_users
  # has_and_belongs_to_many :batches


  # Task Associations
  # belongs_to :tasks
  has_many :created_tasks, class_name: "Task", foreign_key: 'trainer_id'
  has_many :tasks

  scope :show_trainees, -> { where(role: 'trainee')}

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

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
