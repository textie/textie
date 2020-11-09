class LessonSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :order

  has_one :course
end
