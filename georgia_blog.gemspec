# encoding: UTF-8
$:.push File.expand_path("../lib", __FILE__)

require "georgia/blog/version"

Gem::Specification.new do |s|
  s.name        = "georgia_blog"
  s.version     = Georgia::Blog::VERSION
  s.authors     = ["Mathieu Gagné"]
  s.email       = ["gagne.mathieu@hotmail.com"]
  s.homepage    = "http://www.georgiacms.org"
  s.summary     = "Blogging Engine - addon to Georgia"
  s.description = "Adds a blogging engine to Georgia CMS system."
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "georgia"

end
