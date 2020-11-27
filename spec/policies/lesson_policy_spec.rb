require "rails_helper"
require "action_policy/rspec/dsl"

RSpec.describe LessonPolicy do
  let(:user) { build_stubbed(:user) }
  let(:record) { build_stubbed(:lesson) }
  let(:context) { { user: user } }

  describe_rule :index? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  describe_rule :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  describe_rule :manage? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
