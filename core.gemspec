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
  # s.license     = ''

  s.files = Dir['{app,config,db,lib}/**/*', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 4.2.4'
  s.add_dependency 'state_machine'
  s.add_dependency 'globalize', '~> 5.0.0'
  s.add_dependency 'paper_trail', '~> 4.0.0'
  s.add_dependency 'jc-validates_timeliness'

  s.add_development_dependency 'pg'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'rubocop'

  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'shoulda-matchers', '~> 2.8.0'
  s.add_development_dependency 'faker'
  s.add_development_dependency 'rspec-rails'
end
