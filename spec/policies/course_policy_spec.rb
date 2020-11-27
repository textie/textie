require "rails_helper"
require "action_policy/rspec/dsl"

RSpec.describe CoursePolicy do
  let(:record) { build_stubbed(:course) }

  shared_context "when user is the author of the course" do
    let(:record) { create(:course, author: current_user) }
  end

  describe_rule :index? do
    succeed "for any user"
  end

  describe_rule :show? do
    succeed "for any user"
  end

  describe_rule :create? do
    succeed "for any user"
  end

  describe_rule :update? do
    succeed_when "user is the author of the course"
    failed "when user is not the author"
  end
end
