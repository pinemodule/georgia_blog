module Kennedy
  class Engine < ::Rails::Engine
    isolate_namespace Kennedy
    require 'rubygems'
    require 'draper'
  end
end
