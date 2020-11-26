RSpec::Matchers.define :be_a_datetime_string do |expected_time|
  match do |actual_string|
    actual_time = Time.zone.parse(actual_string)
    return false unless actual_time
    return true unless expected_time

    (actual_time - expected_time).abs < 1.second
  end
end
