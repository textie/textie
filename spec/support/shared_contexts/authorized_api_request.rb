RSpec.shared_context "with authorized API request" do
  include_context "with API request"

  let(:current_user) { create(:user) }
  let(:jwt) { LoginUser::GenerateJwt.call(user: current_user).token }

  before do
    header "Authorization", "JWT #{jwt}"
  end
end
