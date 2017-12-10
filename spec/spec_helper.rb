RACK_ENV = 'test'.freeze unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + '/../config/boot')
Dir[File.expand_path(File.dirname(__FILE__) + '/../app/helpers/**/*.rb')].each(&method(:require))

RSpec.configure do |conf|
  conf.include Rack::Test::Methods

<<<<<<< HEAD
  conf.include FactoryBot::Syntax::Methods

  conf.before(:suite) do
    FactoryBot.find_definitions
=======
  # FactoryBot
  conf.include FactoryBot::Syntax::Methods
  FactoryBot.definition_file_paths = [
    File.join(Padrino.root, 'factories'),
    File.join(Padrino.root, 'test', 'factories'),
    File.join(Padrino.root, 'spec', 'factories')
  ]
  FactoryBot.find_definitions

  # Database cleaner
  conf.before(:each) do
    existing_tables = Sequel::Model.db.tables
    tables_to_preserve = %i[schema_info schema_migrations]
    tables_to_be_emptied = existing_tables - tables_to_preserve
    tables_to_be_emptied.each do |table|
      Sequel::Model.db[table].delete
    end
>>>>>>> base
  end
end

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app HockeyStatsTracker::App
#   app HockeyStatsTracker::App.tap { |a| }
#   app(HockeyStatsTracker::App) do
#     set :foo, :bar
#   end
#
def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Padrino.application
end
