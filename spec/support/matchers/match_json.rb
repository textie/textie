require "rspec/expectations"

def similar_json?(expected, actual)
  if expected.is_a?(Date)
    Date.parse(actual) == expected
  elsif expected.is_a?(ActiveSupport::TimeWithZone)
    (Time.zone.parse(actual) - expected).abs < 0.5
  elsif expected.is_a?(Hash)
    actual.is_a?(Hash) &&
      expected.keys.sort == actual.keys.sort &&
      expected.keys.all? { |key| similar_json?(expected[key], actual[key]) }
  elsif expected.is_a?(Array)
    actual.is_a?(Array) &&
      expected.size == actual.size &&
      expected.all? do |expected_item|
        actual.any? { |actual_item| similar_json?(expected_item, actual_item) }
      end
  elsif expected.is_a?(RSpec::Matchers::BuiltIn::BaseMatcher)
    expected.matches?(actual)
  else
    actual == expected
  end
end

RSpec::Matchers.define :match_json do |expected|
  match do |actual|
    actual_hash = actual.is_a?(String) ? JSON.parse(actual) : actual.to_h

    similar_json?(
      expected.with_indifferent_access,
      actual_hash.with_indifferent_access
    )
  end
end
