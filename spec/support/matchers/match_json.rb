require "rspec/expectations"

def similar_dates?(expected, actual)
  Date.parse(actual) == expected
end

def similar_time_with_zones?(expected, actual)
  (Time.zone.parse(actual) - expected).abs < 0.5
end

def similar_hashes?(expected, actual)
  actual.is_a?(Hash) &&
    expected.keys.sort == actual.keys.sort &&
    expected.keys.all? { |key| similar_jsons?(expected[key], actual[key]) }
end

def similar_arrays?(expected, actual)
  actual.is_a?(Array) &&
    expected.size == actual.size &&
    expected.all? do |expected_item|
      actual.any? { |actual_item| similar_jsons?(expected_item, actual_item) }
    end
end

def matches?(expected, actual)
  expected.matches?(actual)
end

def equals?(expected, actual)
  expected == actual
end

JSON_MATCHERS = Hash.new(lambda(&method(:equals?))).merge!(
  Date => lambda(&method(:similar_dates?)),
  ActiveSupport::TimeWithZone => lambda(&method(:similar_time_with_zones?)),
  Hash => lambda(&method(:similar_hashes?)),
  Array => lambda(&method(:similar_arrays?)),
  RSpec::Matchers::BuiltIn::BaseMatcher => lambda(&method(:matches?))
).freeze

def find_json_matcher(expected)
  JSON_MATCHERS.find { |klass, _| expected.is_a?(klass) }&.second || JSON_MATCHERS.default
end

def similar_jsons?(expected, actual)
  find_json_matcher(expected).call(expected, actual)
end

RSpec::Matchers.define :match_json do |expected|
  match do |actual|
    actual_hash = actual.is_a?(String) ? JSON.parse(actual) : actual.to_h

    similar_jsons?(
      expected.with_indifferent_access,
      actual_hash.with_indifferent_access
    )
  end
end
