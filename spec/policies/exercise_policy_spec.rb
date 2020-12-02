require "rails_helper"
require "action_policy/rspec/dsl"

RSpec.describe ExercisePolicy do
  let(:course) { create(:course) }
  let(:lesson) { create(:lesson, course: course) }
  let(:exercise) { create(:multiple_choice_question, lesson: lesson) }
  let(:record) { exercise }

  shared_context "when user is enrolled to the course" do
    before { create(:enrollment, course: course, user: current_user) }
  end

  shared_context "when user is the author of the course" do
    let(:course) { create(:course, author: current_user) }
  end

  describe_rule :index? do
    let(:record) { [exercise] }

    succeed_when "user is the author of the course"
    succeed_when "user is enrolled to the course"
    failed "when user is not enrolled nor author"
  end

  describe_rule :show? do
    succeed_when "user is the author of the course"
    succeed_when "user is enrolled to the course"
    failed "when user is not enrolled nor author"
  end

  %i[create? update? destroy?].each do |rule|
    describe_rule rule do
      succeed_when "user is the author of the course"
      failed_when "user is enrolled to the course"
      failed "when user is not enrolled nor author"
    end
  end
end
