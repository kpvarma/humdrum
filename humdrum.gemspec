# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'humdrum/version'

Gem::Specification.new do |gem|
  gem.name          = "humdrum"
  gem.version       = Humdrum::VERSION
  gem.authors       = ["Krishnan"]
  gem.email         = ["krshnaprsad@gmail.com"]
  gem.description   = %q{humdrum is a collection of useful generators which are quite handy for starting up a project in ruby on rails.}
  gem.summary       = %q{humdrum creates layouts using bootstrap, HTML5boilerplate, modernizer etc to kick start a project.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
