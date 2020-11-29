class ExercisePolicy < ApplicationPolicy
  def index?
    enrolled?
  end

  def show?
    enrolled?
  end

  def create?
    author?
  end

  def update?
    author?
  end

  def destroy?
    author?
  end

  private

  def enrolled?
    Enrollment.exists?(course_id: record.lesson.course_id, user: user)
  end

  def author?
    allowed_to?(:update?, record.lesson)
  end
end
