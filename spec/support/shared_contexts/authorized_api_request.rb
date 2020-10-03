RSpec.shared_context "with authorized API request" do
  include_context "with API request"

  let(:current_user) { create(:user) }
  let(:jwt) { LoginUser::GenerateJwt.call(user: current_user).token }
  let(:auth_header) { { "Authorization" => "JWT #{jwt}" } }
  let(:response_body) do
    do_request
    JSON.parse(response.body)
  end
end
