require "rails_helper"

RSpec.describe RecognizeUser do
  subject(:context) { described_class.call(token: jwt) }

  let(:fake_codec) { instance_double(JwtService) }
  let(:jwt) { "123.456.789" }
  let(:user) { create(:user) }
  let(:user_attributes) { user.slice("id") }

  before do
    allow(JwtService).to receive(:new).and_return(fake_codec)
    allow(fake_codec).to receive(:decode).and_return(user_attributes)
  end

  it { is_expected.to be_a_success }

  it "exposes user" do
    expect(context.user).to have_attributes(user_attributes)
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
