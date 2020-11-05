RSpec.shared_context "with API request" do
  header "Content-Type", "application/json"
  header "Accept", "application/json"

  let(:response) do
    JSON.parse(response_body).with_indifferent_access
  end
end
