class Course < ApplicationRecord
  belongs_to :author, class_name: "User"

  has_many :enrollments, dependent: :restrict_with_error
  has_many :lessons, dependent: :destroy
  has_many :users, through: :enrollments

  validates :title, presence: true
  validates :description, presence: true
end
