module Kennedy
  class Engine < ::Rails::Engine
    require 'rubygems'
    require 'draper'
    require 'georgia'

    extend Georgia::Paths
  end
end