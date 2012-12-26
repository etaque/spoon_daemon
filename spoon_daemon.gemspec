# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spoon_daemon/version'

Gem::Specification.new do |gem|
  gem.name          = "spoon_daemon"
  gem.version       = SpoonDaemon::VERSION
  gem.authors       = ["Emilien Taque"]
  gem.email         = ["e.taque@gmail.com"]
  gem.description   = %q{Daemon tool for JRuby based on Spoon.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency(%q<spoon>, [">= 0.0.1"])
end
