require "badgfy/activity.rb"
require "badgfy/configuration.rb"
require "badgfy/version"

module Badgfy
  class << self

    attr_accessor :configuration

    def config
      self.configuration ||= Configuration.new
    end

    def configure
      yield config
    end

  end
end
