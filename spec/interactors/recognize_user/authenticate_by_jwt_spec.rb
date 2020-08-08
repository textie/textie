require "rails_helper"

RSpec.describe RecognizeUser::AuthenticateByJwt do
  subject(:context) { described_class.call(token: jwt) }

  let(:fake_codec) { instance_double(JwtCodec) }
  let(:jwt) { "123.456.789" }
  let(:user_attributes) { { id: 1, email: "user@example.com" } }

  before do
    allow(JwtCodec).to receive(:new).and_return(fake_codec)
    allow(fake_codec).to receive(:decode).with(jwt).and_return(user_attributes)
  end

  it { is_expected.to be_a_success }

  it "exposes user" do
    expect(context.user).to have_attributes(user_attributes)
  end

  context "with invalid token" do
    before do
      allow(fake_codec).to receive(:decode).with(jwt).and_return(nil)
    end

    it "fails" do
      expect(context).to be_a_failure
    end
  end
end
