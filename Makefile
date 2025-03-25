cuke:
	bundle exec cucumber

fix:  # Fix all auto-fixable issues
	find . -name '*.rb' | xargs bundle exec rubocop -A
	bundle exec rubocop -A active_cucumber.gemspec
	dprint fmt

help:  # prints all available targets
	@grep -h -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?# "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

lint:  # Run linters
	find . -name '*.rb' | xargs bundle exec rubocop
	dprint check

setup:
	bundle install

test: lint cuke  # run all tests

.SILENT:
.DEFAULT_GOAL := help
