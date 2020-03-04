$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "active_flags/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "active_flags"
  spec.version     = ActiveFlags::VERSION
  spec.authors     = ["Nathan Huberty"]
  spec.email       = ["nathan.huberty@orange.fr"]
  spec.homepage    = "https://github.com/FidMe/active_flags"
  spec.summary     = "Easily declare flags for your models."
  spec.description = "Easily declare flags for your models."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 5.0"

  spec.add_development_dependency "sqlite3"
end
