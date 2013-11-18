# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'humdrum/version'

Gem::Specification.new do |gem|
  
  gem.name          = "humdrum-rails"
  gem.email         = "krishnaprasadvarma@gmail.com"
  gem.version       = Humdrum::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ["Krishnan"]
  gem.license       = "MIT"
  gem.homepage    = "http://github.com/humdrum"
  gem.description   = %q{humdrum-rails is a collection of useful generators which are quite handy for starting up a project in ruby on railgem.}
  gem.summary       = %q{humdrum-rails creates layouts using bootstrap, HTML5boilerplate etc to kick start a project.}
  
  gem.rubyforge_project  = "humdrum"
  
  gem.files         = `git ls-files`.split("\n")
  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_runtime_dependency(%q<colorize>, ["~> 0.5.8"])
  
  gem.add_development_dependency 'rails', '~> 3.0.0'
  gem.add_development_dependency 'rainbow'
  gem.add_development_dependency 'rainbow'
  gem.add_development_dependency 'handy-css-rails', '0.0.4'
  
  
end
