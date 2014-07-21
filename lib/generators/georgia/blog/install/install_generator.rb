module Georgia
  module Blog
    module Generators
      class InstallGenerator < ::Rails::Generators::Base

        def run_migrations
          rake "railties:install:migrations"
          rake "db:migrate"
        end

        def create_index
          Georgia::Blog::Post.__elasticsearch__.indices.delete! Georgia::Blog::Post.index_name rescue nil
          Georgia::Blog::Post.__elasticsearch__.create_index! force: true
          Georgia::Blog::Post.import
        end

      end
    end
  end
end