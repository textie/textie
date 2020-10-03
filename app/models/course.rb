class Course < ApplicationRecord
  belongs_to :author, class_name: "User"

  has_many :enrollments, dependent: :destroy
  has_many :users, through: :enrollments
end
