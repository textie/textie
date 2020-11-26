class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :course,
            uniqueness: {
              scope: :user,
              message: I18n.t("enrollment.errors.course_taken")
            }
end
