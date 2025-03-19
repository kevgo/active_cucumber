lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = 'active_cucumber'
  gem.version       = '1.0.0'
  gem.authors       = ['Kevin Goslar']
  gem.email         = ['kevin.goslar@gmail.com']
  gem.summary       = %s(ActiveRecord tools for Cucumber)
  gem.description   = %s(Tools to compare ActiveRecord entries with Cucumber tables)
  gem.homepage      = 'https://github.com/kevgo/active_cucumber'
  gem.license       = 'MIT'

  gem.files         = `git ls-files -z`.split("\x0")
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 2.7'
  gem.metadata['rubygems_mfa_required'] = 'true'
end
