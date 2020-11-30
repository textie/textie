class QuestionOptionSerializer < ActiveModel::Serializer
  # include ActionPolicy::Behaviour
  # authorize :user, through: :current_user

  attributes :id, :value
  attribute :correct, if: :author?

  def author?
    # TODO: issue action policy
    # allowed_to?(:update, object.question.lesson.course)
    current_user.id == object.question.lesson.course.author_id
  end
end
