require 'core/oauth_connection/base'

module OAuthConnection
  class Password < Base

    class Error < Base::Exception; end

    def call(params = {})
      raise Error unless valid?(params)

      token_params = get_oauth_token(oauth_params(params))
      get_access(token_params)
      raw_info

      self
    rescue ::OAuth2::Error => e
      raise Error, e
    end

    private

    def oauth_params(params)
      super().merge(
        {
          user: {
            email:        params[:email],
            password:     params[:password]
          }
        }
      )
    end

    def valid?(params)
      !params[:email].blank? && !params[:password].blank?
    end

    def grant_type
      'password'
    end
  end
end