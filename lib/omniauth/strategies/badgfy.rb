module OmniAuth
  module Strategies

    class Badgfy < OmniAuth::Strategies::OAuth2
      option :name, :badgfy

      option :client_options, {
        site: "http://localhost:3000",
        authorize_path: "/oauth/authorize",
        client_id: "",
        client_secret: ""
      }
    end

  end
end
