RSpec.shared_context "with authorized API request" do
  include_context "with API request"

  let(:current_user) { create(:user) }
  let(:jwt) { LoginUser::GenerateJwt.call(user: current_user).token }

  before { header "Authorization", "JWT #{jwt}" }
end
