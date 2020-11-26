require "rspec_api_documentation"

RspecApiDocumentation.configure do |config|
  config.docs_dir = Rails.root.join("doc")
  config.format = :json
  config.keep_source_order = true
  config.request_body_formatter = :json

  config.curl_host = "http://lvh.me:3000"
  config.curl_headers_to_filter = %w[Host Cookie Origin]
  config.request_headers_to_include = %w[Content-Type Accept Authorization]
  config.response_headers_to_include = %w[Content-Type Referrer-Policy]
end

# https://github.com/zipmark/rspec_api_documentation/issues/456
module RspecApiDocumentation
  class RackTestClient < ClientBase
    def response_body
      if last_response.headers["Content-Type"].include?("json")
        last_response.body.encode("utf-8")
      else
        "[binary data]"
      end
    end
  end
end
