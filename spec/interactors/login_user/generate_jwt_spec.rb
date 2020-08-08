require "spec_helper"

RSpec.describe LoginUser::GenerateJwt do
  subject(:result) { described_class.call(user: user) }

  let(:user) { create(:user, raw_user_attributes) }
  let(:fake_codec) { instance_double(JwtCodec) }
  let(:raw_user_attributes) do
    { email: "jwt_user@example.com", full_name: "Simon Petrikov" }
  end
  let(:user_attributes) { raw_user_attributes.merge(id: user.id) }

  before do
    allow(JwtCodec).to receive(:new).and_return(fake_codec)
    allow(fake_codec).to receive(:encode)
      .with(user_attributes).and_return("8")
  end

  it { is_expected.to be_a_success }

  it "invokes jwt codec" do
    result
    expect(fake_codec).to have_received(:encode)
  end

  it "exposes token" do
    expect(result.token).to eq("8")
  end
end
