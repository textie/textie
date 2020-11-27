require "simplecov"

SimpleCov.start do
  add_filter "/spec/"
  add_filter "/config/"

  %w[
    controllers jobs interactors models serializers services
  ].each { |group| add_group(group, "app/#{group}") }
end
