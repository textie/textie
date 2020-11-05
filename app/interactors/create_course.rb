class CreateCourse
  include Interactor

  delegate :course, to: :context

  def call
    context.fail!(errors: course.errors) unless course.save
  end
end
