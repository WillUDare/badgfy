module Badgfy
  module Generators
    class InstallGenerator < ::Rails::Generators::Base

      source_root File.expand_path('../../templates', __FILE__)

      desc 'Creates a Badgfy initializer for your application'

      def copy_initializer
        template 'initializer.rb', 'config/initializers/badgfy.rb'
      end

    end
  end
end