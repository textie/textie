require "rails_helper"

RSpec.describe RefreshAuthentication::CreateRefreshToken do
  subject(:call) { described_class.call(user: user) }

  let(:user) { create(:user, id: 343_173) }
  let(:fake_codec) { instance_double(JwtService) }

  before do
    allow(JwtService).to receive(:new).and_return(fake_codec)
    allow(fake_codec).to receive(:encode).and_return("e.3.j")
  end

  it { is_expected.to be_a_success }

  it "exposes refresh token" do
    expect(call).to have_attributes(refresh_token: "e.3.j")
  end

  it "creates refresh token" do
    expect { call }.to change(RefreshToken, :count).by(1)
  end

  it "writes id to JWT" do
    call

    expect(fake_codec).to have_receive(:encode).with(
      id: be_an(Integer)
    )
  end
end
