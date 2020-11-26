class CreateLesson
  include Interactor

  delegate :lesson, to: :context
  delegate :course, to: :lesson

  def call
    set_default_order
    context.fail!(errors: lesson.errors) unless lesson.save
  end

  private

  def set_default_order
    lesson.order ||= course.lessons.maximum(:order) || 1
  end
end
