RSpec.shared_context "with API request" do
  let(:response_body) do
    do_request
    JSON.parse(response.body)
  end
end
