module AcceptanceHelpers
  extend ActiveSupport::Concern

  included do
    include_context "with API request"
  end
end

RSpec.configure do |config|
  config.include AcceptanceHelpers, type: :acceptance
end
