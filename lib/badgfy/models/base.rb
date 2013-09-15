require 'faraday_middleware'

module Badgfy
  module Models

    class Base < ::ActiveResource::Base
      self.site   = "http://localhost:3000"

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

        def get_access_token
          conn = Faraday.new(url: self.site) do |faraday|
            faraday.request   :json
            faraday.response  :json, content_type: /\bjson$/
            faraday.use       :instrumentation
            faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
          end

          response = conn.post '/oauth/token', {
            grant_type: "password",
            user: {
              email: Badgfy.config.username,
              password: Badgfy.config.password,
            },
            client_id: Badgfy.config.app_id,
            client_secret: Badgfy.config.app_secret
          }

          puts response
          puts response.body
        end

      end

    end

  end
end
