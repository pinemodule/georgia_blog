module Georgia
  module Blog
    class Engine < ::Rails::Engine
      require 'rubygems'
      require 'georgia'

      extend Georgia::Paths
    end
  end
end