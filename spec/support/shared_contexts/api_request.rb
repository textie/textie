RSpec.shared_context "with API request" do
  before do
    header "Content-Type", "application/json"
    header "Accept", "application/json"
  end

  let(:body) do
    JSON.parse(response_body).with_indifferent_access
  end

  let(:cookies) do
    response_headers["Set-Cookie"]
      .split("\n")
      .map { |cookie| cookie.split("\; ")[0].split("=") }
      .to_h.with_indifferent_access
  end
end
