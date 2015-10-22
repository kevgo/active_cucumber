lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name          = 'active_cucumber'
  s.version       = '0.0.3'
  s.authors       = ['Kevin Goslar']
  s.email         = ['kevin.goslar@gmail.com']
  s.summary       = %s(ActiveRecord tools for Cucumber)
  s.description   = %s(Tools to compare ActiveRecord entries with Cucumber tables)
  s.homepage      = 'https://github.com/Originate/active_cucumber'
  s.license       = 'MIT'

  s.files         = `git ls-files -z`.split("\x0")
  s.test_files    = Dir['features/*']
  s.require_paths = ['lib']

  s.add_development_dependency 'activerecord'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'cucumber_lint'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'faker'
  s.add_development_dependency 'kappamaki'
  s.add_development_dependency 'mortadella'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-collection_matchers'
  s.add_development_dependency 'sqlite3'
end
