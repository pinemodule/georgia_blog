module GeorgiaBlog
  class Engine < ::Rails::Engine
    require 'rubygems'
    require 'georgia'

    extend Georgia::Paths
  end
end