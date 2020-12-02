class Exercise < ApplicationRecord
  belongs_to :lesson

  validates :title, presence: true
  validates :description, presence: true

  def policy_class
    ExercisePolicy
  end
end
