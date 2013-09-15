require 'rubygems'
require 'active_resource'
require 'omniauth-oauth2'

require 'models'

require "badgfy/configuration"
require "badgfy/version"

require "omniauth/strategies/badgfy"

module Badgfy
  class << self

    attr_accessor :configuration

    def config
      self.configuration ||= Configuration.new
    end

    def configure
      yield config
    end

    def api_url_base
      "http://localhost:3000/"
    end

  end
end
