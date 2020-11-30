class ExerciseSerializer < ActiveModel::Serializer
  attributes :id, :type, :title, :description, :lesson_id
end
