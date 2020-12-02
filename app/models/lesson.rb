class Lesson < ApplicationRecord
  belongs_to :course

  has_many :exercises, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
  validates :order, presence: true, uniqueness: { scope: :course }
end
