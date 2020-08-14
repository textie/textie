class User < ApplicationRecord
  has_secure_password

  has_many :author_courses, class_name: "Course", dependent: :restrict_with_exception

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
