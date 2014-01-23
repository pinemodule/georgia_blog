# encoding: UTF-8
$:.push File.expand_path("../lib", __FILE__)

require "georgia_blog/version"

Gem::Specification.new do |s|
  s.name        = "georgia_blog"
  s.version     = Kennedy::VERSION
  s.authors     = ["Mathieu Gagné"]
  s.email       = ["mathieu@motioneleven.com", "gagne.mathieu@hotmail.com"]
  s.homepage    = "https://github.com/georgia-cms/georgia_blog"
  s.summary     = "Blogging Engine - addon to Georgia"
  s.description = "Adds a blogging engine to Motion Eleven's Georgia CMS system."
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "georgia"
end
