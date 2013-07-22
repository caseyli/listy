# -*- encoding: utf-8 -*-
require File.expand_path('../lib/listy/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Casey Li"]
  gem.email         = ["casey.li@gmail.com"]
  gem.description   = %q{"A bunch of helpers to create fancy lists"}
  gem.summary       = %q{"Everything for list of links from collections to multi-column lists"}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "listy"
  gem.require_paths = ["lib"]
  gem.version       = Listy::VERSION
end
