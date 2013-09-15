module Badgfy
  class Configuration

    attr_accessor :app_id, :app_secret, :username, :password

    def initialize
      @app_id     = ""
      @app_secret = ""
      @usernam    = ""
      @password   = ""
    end

  end
end