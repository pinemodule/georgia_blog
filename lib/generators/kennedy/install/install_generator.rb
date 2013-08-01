module Kennedy
  module Generators
    class InstallGenerator < ::Rails::Generators::Base

      desc "Generate migration for Kennedy CMS Models"

      def bootstrap
        rake "kennedy:setup"
      end

    end
  end
end