class LessonSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :order

  belongs_to :course
end
