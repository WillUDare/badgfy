module Badgfy
  module Models

    class Activity < Base
      self.prefix = "/sites/:site_id/"

      def create
        puts "HERE"
        Base::token.create(params)
      end

    end

  end
end