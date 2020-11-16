require "rails_helper"

RSpec.describe RecognizeUser do
  subject(:context) { described_class.call(token: jwt) }

  let(:fake_codec) { instance_double(JwtService) }
  let(:jwt) { "123.456.789" }
  let(:user) { create(:user) }
  let(:jwt_payload) do
    {
      "sub" => user.id,
      "iat" => 1_605_556_236
    }
  end

  before do
    allow(JwtService).to receive(:new).and_return(fake_codec)
    allow(fake_codec).to receive(:decode).and_return(jwt_payload)
  end

  it { is_expected.to be_a_success }

  it "exposes user" do
    expect(context.user).to eq(user)
  end

  context "with invalid token" do
    before do
      allow(fake_codec).to receive(:decode).and_return(nil)
    end

    it "fails" do
      expect(context).to be_a_failure
    end
  end
end
