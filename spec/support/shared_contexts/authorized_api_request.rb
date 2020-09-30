RSpec.shared_context "with authorized API request" do
  include_context "with API request"

  let(:response_body) do
    do_request
    JSON.parse(response.body)
  end
end
