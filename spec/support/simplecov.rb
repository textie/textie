SimpleCov.configure do
  add_filter %r{^/spec/}
  add_filter %r{^/config/}

  add_group "Models", "app/models"
  add_group "Controllers", "app/controllers"
  add_group "Interactors", "app/interactors"
  add_group "Services", "app/services"
  add_group "Jobs", "app/jobs"
  add_group "Serializers", "app/serializers"
end
