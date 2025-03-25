# frozen_string_literal: true

require "bundler"
require "bundler/gem_tasks"
require "cucumber"
require "cucumber/rake/task"

Cucumber::Rake::Task.new :features
task default: [:lint, :features]

desc "Fix all auto-fixable issues"
task "fix" do
  sh "find . -name '*.rb' | xargs bundle exec rubocop -A"
  sh "bundle exec rubocop -A active_cucumber.gemspec"
  sh "dprint fmt"
end

desc "Run linters"
task "lint" do
  sh "find . -name '*.rb' | xargs bundle exec rubocop"
  sh "dprint check"
end
