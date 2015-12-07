ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../dummy/config/environment.rb', __FILE__)

require 'byebug'
require 'faker'
require 'jc-validates_timeliness'
require 'globalize'
require 'rspec/rails'
require 'paper_trail'
require 'paper_trail/frameworks/active_record'
require 'shoulda/matchers'
require 'state_machine'

require 'factory_girl'

factories_dir = File.join(File.dirname(__FILE__), 'factories')
FactoryGirl.definition_file_paths << factories_dir
FactoryGirl.find_definitions

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{ File.dirname(__FILE__) }/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'
end
