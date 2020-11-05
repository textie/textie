RSpec.shared_context "with API request" do
  let(:response) do
    JSON.parse(response_body).with_indifferent_access
  end
end
