# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"
require 'rswag/specs' if defined?(Rswag::Specs)
require 'rswag/api'
require 'rspec/core/rake_task'

Rails.application.load_tasks
