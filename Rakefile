require 'rake'
require 'rspec/core/rake_task'


require ::File.expand_path('../config/environment', __FILE__)

# Include all of ActiveSupport's core class extensions, e.g., String#camelize
require 'active_support/core_ext'

namespace :generate do
  desc "Create an empty model in app/models, e.g., rake generate:model NAME=User"
  task :model do
    unless ENV.has_key?('NAME')
      raise "Must specificy model name, e.g., rake generate:model NAME=User"
    end

    model_name     = ENV['NAME'].camelize
    model_filename = ENV['NAME'].underscore + '.rb'
    model_path = APP_ROOT.join('app', 'models', model_filename)

    if File.exist?(model_path)
      raise "ERROR: Model file '#{model_path}' already exists"
    end

    puts "Creating #{model_path}"
    File.open(model_path, 'w+') do |f|
      f.write(<<-EOF.strip_heredoc)
        class #{model_name} < ActiveRecord::Base
          # Remember to create a migration!
        end
      EOF
    end
  end

  desc "Create an empty migration in db/migrate, e.g., rake generate:migration NAME=create_tasks"
  task :migration do
    unless ENV.has_key?('NAME')
      raise "Must specificy migration name, e.g., rake generate:migration NAME=create_tasks"
    end

    name     = ENV['NAME'].camelize
    filename = "%s_%s.rb" % [Time.now.strftime('%Y%m%d%H%M%S'), ENV['NAME'].underscore]
    path     = APP_ROOT.join('db', 'migrate', filename)

    if File.exist?(path)
      raise "ERROR: File '#{path}' already exists"
    end

    puts "Creating #{path}"
    File.open(path, 'w+') do |f|
      f.write(<<-EOF.strip_heredoc)
        class #{name} < ActiveRecord::Migration
          def change
          end
        end
      EOF
    end
  end

  desc "Create an empty folder in views"
  task :controller do
    unless ENV.has_key?('NAME')
      raise "Must specificy controller name, e.g., rake generate:controller NAME=user"
    end

    name     = ENV['NAME'].downcase
    filename = ENV['NAME'].underscore + '.rb'
    path     = APP_ROOT.join('app', 'controllers', filename)

    if File.exist?(path)
      raise "ERROR: File '#{path}' already exists"
    end

    puts "Creating #{path}"
    File.open(path, 'w+') do |f|
      f.write(<<-EOF.strip_heredoc)
        post '/#{name}/new' do
          new_object = #{name.camelize}.new(params[#{name}])
          if new_object.save
            redirect to("/#{name}_views/all")
          else
            @errors = #{name}.errors.messages
            erb :"#{name}_views/new"
          end
        end
        
        get '/#{name}/edit' do
          edit_object = #{name.camelize}.find(params[:#{name}_id])
          edit_object.update_attributes(params)
          redirect to('/')
        end

        get '/#{name}/delete' do
          #{name} = #{name.camelize}.find( )
          #{name}.destroy
          redirect to('/')
        end
      EOF
     end
  end



  desc "Creating MVC....and migration...ignore migration at own risk"
  task :scaffold do
    unless ENV.has_key?('NAME')
      raise "Must specificy model name, e.g., rake generate:scaffold NAME=user"
    end

    name     = ENV['NAME'].downcase
    migration_name = "create_#{ENV['NAME'].downcase.pluralize}"

    puts "Making all the stuff for the #{name} table...sit and relax"
    exec("mkdir app/views/#{name}_views && touch app/views/#{name}_views/edit.erb && touch app/views/#{name}_views/new.erb && touch app/views/#{name}_views/show.erb && bundle exec rake generate:model NAME=#{name} && bundle exec rake generate:controller NAME=#{name.downcase.pluralize} && bundle exec rake generate:migration NAME=#{migration_name}")
  end




  desc "Create an empty model spec in spec, e.g., rake generate:spec NAME=user"
  task :spec do
    unless ENV.has_key?('NAME')
      raise "Must specificy migration name, e.g., rake generate:spec NAME=user"
    end

    name     = ENV['NAME'].camelize
    filename = "%s_spec.rb" % ENV['NAME'].underscore
    path     = APP_ROOT.join('spec', filename)

    if File.exist?(path)
      raise "ERROR: File '#{path}' already exists"
    end

    puts "Creating #{path}"
    File.open(path, 'w+') do |f|
      f.write(<<-EOF.strip_heredoc)
        require 'spec_helper'

        describe #{name} do
          pending "add some examples to (or delete) #{__FILE__}"
        end
      EOF
    end
  end

end

namespace :db do

  desc "reset the database"
  task :reset do
    puts "resetting the frakking db"
    exec("bundle exec rake db:drop && bundle exec rake db:set")
  end

  desc "set the database"
  task :set do
    puts "Create-Migrate-Seed...ALL AT ONCE"
    exec("bundle exec rake db:create && bundle exec rake db:migrate && bundle exec rake db:seed")
  end

  desc "create/migrate/seed db and open the console"
  task :conset do
    puts "setting db and entering console"
    exec("bundle exec rake db:drop && bundle exec rake console")
  end

  desc "reset the db and opening the console"
  task :conreset do
    puts "resetting the frakking db and entering rake console"
    exec("bundle exec rake db:reset && bundle exec rake console")
  end

  desc "Create the database at #{DB_NAME}"
  task :create do
    puts "Creating database #{DB_NAME} if it doesn't exist..."
    exec("createdb #{DB_NAME}")
  end

  desc "Drop the database at #{DB_NAME}"
  task :drop do
    puts "Dropping database #{DB_NAME}..."
    exec("dropdb #{DB_NAME}")
  end

  desc "Migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
  task :migrate do
    ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
    ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
    ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
      ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
    end
  end

  desc "Populate the database with dummy data by running db/seeds.rb"
  task :seed do
    require APP_ROOT.join('db', 'seeds.rb')
  end

  desc "Returns the current schema version number"
  task :version do
    puts "Current version: #{ActiveRecord::Migrator.current_version}"
  end
end

desc 'Start User-InterRake'
task "launch" do
  puts "Table generator...Type 'q' to quit"
  input = STDIN.gets.chomp
  exec "echo #{input}"
  exec "irb -r./config/environment"

end


desc 'Start IRB with application environment loaded'
task "console" do
  exec "irb -r./config/environment"
end

desc "Run the specs"
RSpec::Core::RakeTask.new(:spec)

task :default  => :specs