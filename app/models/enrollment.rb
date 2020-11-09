class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :user,
            uniqueness: {
              scope: :course,
              message: I18n.t("enrollment.errors.course_taken")
            }
end
