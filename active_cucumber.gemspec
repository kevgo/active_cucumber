lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name          = 'active_cucumber'
  s.version       = '1.0.0'
  s.authors       = ['Kevin Goslar']
  s.email         = ['kevin.goslar@gmail.com']
  s.summary       = %s(ActiveRecord tools for Cucumber)
  s.description   = %s(Tools to compare ActiveRecord entries with Cucumber tables)
  s.homepage      = 'https://github.com/kevgo/active_cucumber'
  s.license       = 'MIT'

  s.files         = `git ls-files -z`.split("\x0")
  s.require_paths = ['lib']

  s.metadata['rubygems_mfa_required'] = 'true'
end
