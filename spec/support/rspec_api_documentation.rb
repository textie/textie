require "rspec_api_documentation"

RspecApiDocumentation.configure do |config|
  config.format = %i[json]
  config.curl_host = "http://localhost:3000"
  config.api_name = "API"
  config.docs_dir = Rails.root.join("doc")
  config.curl_headers_to_filter = %w[Host Cookie Origin]
end

# https://github.com/zipmark/rspec_api_documentation/issues/456
module RspecApiDocumentation
  class RackTestClient < ClientBase
    def response_body
      last_response.body.encode("utf-8")
    end
  end
end
