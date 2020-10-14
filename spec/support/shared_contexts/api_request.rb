RSpec.shared_context "with API request" do
  header "Content-Type", "application/json"
  header "Accept", "application/json"

  let(:response_body) do
    do_request
    JSON.parse(response.body)
  end
end
