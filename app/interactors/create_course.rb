class CreateCourse
  include Interactor

  delegate :course, :user, to: :context

  def call
    course.author = user
    context.fail!(errors: course.errors) unless course.valid?
    course.save!
  end
end
