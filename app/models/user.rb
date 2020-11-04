class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments
end
