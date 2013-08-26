module Kennedy
  class Engine < ::Rails::Engine
    require 'rubygems'
    require 'georgia'

    extend Georgia::Paths
  end
end