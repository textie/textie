# Use in acceptance tests
# example usage:
#
# with_options do
#   parameter :email, required: true
#   parameter :password, reuired: true
# end
#
# let(:email) { "" }
# let(:password) { "123456" }
#
# it_behaves_like "error response", email: %w[blank invalid]

RSpec.shared_examples "error response" do |errors_hash|
  let(:errors_matcher) do
    errors_hash.transform_values do |errors|
      errors.map { |e| include(e) }
    end
  end

  example "responds with errors", document: false do
    do_request
    expect(body).to include(errors: errors_matcher)
  end
end
