RSpec.shared_context "with policy" do
  let(:current_user) { create(:user) }
  let(:context) { { user: current_user } }
end
