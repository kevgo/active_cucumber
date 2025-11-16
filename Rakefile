# frozen_string_literal: true

require "bundler"
require "bundler/gem_tasks"
require "cucumber"
require "cucumber/rake/task"

Cucumber::Rake::Task.new :features

# Runs all tests
task test: [:lint, :features]

task default: :test


desc "Fix all auto-fixable issues"
task "fix" do
  sh "bundle exec rubocop -A lib/*.rb lib/**/*.rb active_cucumber.gemspec", verbose: false
  sh "dprint fmt", verbose: false
end

desc "Run linters"
task "lint" do
  sh "bundle exec rubocop lib/*.rb lib/**/*.rb active_cucumber.gemspec", verbose: false
  sh "dprint check", verbose: false
end
