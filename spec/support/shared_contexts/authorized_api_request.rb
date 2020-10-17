RSpec.shared_context "with authorized API request" do
  let(:current_user) { create(:user) }
  let(:jwt) { LoginUser::GenerateJwt.call(user: current_user).token }

  before do
    header "Accept", "application/json"
    header "Authorization", "JWT #{jwt}"
    header "Content-Type", "application/json"
  end
end
