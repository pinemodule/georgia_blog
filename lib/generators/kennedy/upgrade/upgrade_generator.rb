module Kennedy
  module Generators
    class UpgradeGenerator < ::Rails::Generators::Base

      desc "Upgrade migration for Kennedy"

      def upgrade
        rake "kennedy:upgrade"
      end

    end
  end
end