RSpec.shared_context "with authorized API request" do
  include_context "with API request"

  let(:current_user) { create(:user) }
  let(:jwt) do
    LoginUser::GenerateAccessToken.call(user: current_user).access_token
  end

  before do
    header "Authorization", "JWT #{jwt}"
  end
end
