# frozen_string_literal: true

require 'bundler'
require 'bundler/gem_tasks'
require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new :features
task default: [:lint, :features]

desc 'Fix all auto-fixable issues'
task 'fix' do
  sh 'bundle exec rubocop -A'
  sh 'dprint fmt'
end

desc 'Run linters'
task lint: %w[lint:ruby lint:cucumber]

desc 'Run Cucumber linter'
task 'lint:cucumber' do
  sh 'bundle exec cucumber_lint'
end

desc 'Run Ruby linter'
task 'lint:ruby' do
  # NOTE: cannot use "task 'lint:ruby' => [:rubocop]" here,
  #       because the Heroku toolbelt has issues with JRuby.
  #       In particular, running "heroku run rake db:migrate"
  #       fails when JRuby is the active Ruby at this point.
  sh 'bundle exec rubocop'
end
