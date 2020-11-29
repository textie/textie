class ExerciseSerializer < ActiveModel::Serializer
  attributes :id, :type, :title, :description, :order, :lesson_id
end
