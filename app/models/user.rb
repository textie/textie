class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :enrollments
  has_many :courses, through: :enrollments
  has_many :authored_courses, class_name: "Course", foreign_key: :author_id
end
