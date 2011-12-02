# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sapling/version"

Gem::Specification.new do |s|
  s.name        = "sapling"
  s.version     = Sapling::VERSION
  s.authors     = ["Jason Strutz"]
  s.email       = ["navyrain@navyrain.net"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "sapling"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec", "~>2.7.0"
  s.add_development_dependency "mocha"
  s.add_development_dependency "activerecord", "~>3.1.1"
end
