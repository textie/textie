class ExercisePolicy < ApplicationPolicy
  def index?
    Lesson.find(record.pluck(:lesson_id)).all? do |lesson|
      allowed_to?(:show?, lesson)
    end
  end

  def show?
    enrolled? || author?
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
