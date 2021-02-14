class CoursePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def update?
    author?
  end

  private

  def author?
    user.id == record.author_id
  end
end
