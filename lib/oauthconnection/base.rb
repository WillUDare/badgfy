require 'faraday_middleware'

module OAuthConnection
  class Base

    class Exception < StandardError; end

    attr_reader :connection, :access, :raw_info, :oauth

    def call
      raise 'you must implement this method'
    end

    def uid
      raw_info.try(:[], 'id')
    end

    def info
      {
        email:                raw_info.try(:[], 'email'),
        authentication_token: raw_info.try(:[], 'authentication_token'),
      }
    end

    private

    def oauth_params
      {
        grant_type:    grant_type,
        client_id:     Badgfy.config.app_id,
        client_secret: Badgfy.config.app_secret
      }
    end

    def connection
      @connection ||= Faraday.new(url: Badgfy.api_url_base) do |builder|
        builder.request   :json
        builder.response  :json, content_type: /\bjson$/
        builder.use       :instrumentation
        builder.adapter   Faraday.default_adapter
      end
    end

    def get_oauth_token(params = {})
      connection.post('/oauth/token', params).body
    end

    def get_access(token_params)
      client  ||= OAuth2::Client.new(Badgfy.config.app_id, Badgfy.config.app_secret, site: Badgfy.api_url_base)
      @access ||= OAuth2::AccessToken.from_hash(client,
        access_token: token_params['access_token'],
        token_type:   'bearer',
        expires_in:   7200
      )
    end
 
    def raw_info
      @raw_info ||= access.get(raw_info_path).parsed
    end
 
    def raw_info_path
      '/admin/users/me'
    end
 
    def grant_type
      raise 'you must implement this method'
    end
  end
end
