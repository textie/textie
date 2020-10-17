RSpec.shared_context "with API request" do
  before do
    header "Content-Type", "application/json"
    header "Accept", "application/json"
  end
end
