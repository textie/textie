class LessonPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    author? || enrolled?
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
    Enrollment.exists?(course_id: record.course_id, user: user)
  end

  def author?
    allowed_to?(:update?, record.course)
  end
end
