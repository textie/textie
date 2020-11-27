module PolicyHelpers
  extend ActiveSupport::Concern

  included do
    include_context "with policy"
    extend ClassMethods
  end

  module ClassMethods
    def succeed_when(shared_context_name)
      succeed("when #{shared_context_name}") do
        include_context("when #{shared_context_name}")
      end
    end

    def failed_when(shared_context_name)
      failed("when #{shared_context_name}") do
        include_context("when #{shared_context_name}")
      end
    end
  end
end

RSpec.configure do |config|
  config.include PolicyHelpers, type: :policy
end
