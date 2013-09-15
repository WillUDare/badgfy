require 'faraday_middleware'

module Badgfy
  module Models

    class Base < ::ActiveResource::Base
      self.site   = "http://localhost:3000/api/#{version}"

      class << self

        def oauth
          @oauth ||= OmniAuth::Strategies::Badgfy.new ""
        end

        def token
          get_access_token
          @token ||= oauth.access_token
        end

        def headers
          @headers = { authorization: 'Bearer ' + token }
        end

        def version
          "v1"
        end

      end

    end

  end
end
