class EnrollmentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :course_id
end
