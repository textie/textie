RSpec.shared_context :when_time_is_frozen do
  let(:current_time) { Time.new(2020, 3, 15, 14, 0_0, 0_0, "+03:00").in_time_zone("Moscow") }

  before { Timecop.freeze(current_time) }

  after { Timecop.return }
end
