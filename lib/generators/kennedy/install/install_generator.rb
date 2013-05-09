# encoding: UTF-8
require 'rails/generators/migration'

module Kennedy
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)

      desc "Generate migration for Kennedy CMS Models"

      def mount_engine
        route "mount Kennedy::Engine => '/admin'"
      end

      def self.next_migration_number(dirname)
        Time.now.strftime("%Y%m%d%H%M%S")
      end

      def create_migration
        migration_template "create_kennedy_categories.rb", "db/migrate/create_kennedy_categories.rb"
      end

      def copy_config
        template "config/initializers/kennedy.rb"
      end

      def migrate
        rake "db:migrate"
      end

      def bootstrap
        rake "kennedy:setup"
      end

    end
  end
end