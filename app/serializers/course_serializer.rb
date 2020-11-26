class CourseSerializer < ActiveModel::Serializer
  attributes :id, :author_id, :title, :description, :created_at
end
