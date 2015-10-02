$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'core/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'core'
  s.version     = Core::VERSION
  s.authors     = ['Cupli developers']
  # s.email       = []
  s.homepage    = 'http://cup.li/'
  s.summary     = "Core of Cupli's applications"
  # s.description = 'TODO: Description of Core.'
  # s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", 'Rakefile', 'README.rdoc']
  # s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '~> 4.2.4'

  s.add_development_dependency 'pg'
end
