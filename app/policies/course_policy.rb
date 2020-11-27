class CoursePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user
  end

  def update?
    author?
  end

  def destroy?
    false
  end

  private

  def author?
    user.id == record.author_id
  end
end
