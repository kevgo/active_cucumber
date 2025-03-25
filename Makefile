cuke:
	bundle exec cucumber

setup:
	bundle install

fix:  # Fix all auto-fixable issues
	find . -name '*.rb' | xargs bundle exec rubocop -A
	bundle exec rubocop -A active_cucumber.gemspec
	dprint fmt

lint:  # Run linters
	find . -name '*.rb' | xargs bundle exec rubocop
	dprint check

test: lint cuke  # run all tests
