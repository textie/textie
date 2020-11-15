RSpec.shared_context "with authorized API request" do
  include_context "with API request"

  let(:current_user) { create(:user) }
  let(:jwt) do
    LoginUser::GenerateAccessToken.call(user: current_user).access_token
  end
  let(:auth_header) { { "Authorization" => "JWT #{jwt}" } }
  let(:response_body) do
    do_request
    JSON.parse(response.body)
  end
end
