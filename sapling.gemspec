# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sapling/version"

Gem::Specification.new do |s|
  s.name        = "sapling"
  s.version     = Sapling::VERSION
  s.authors     = ["Shane Brinkman-Davis", "Jason Strutz"]
  s.email       = ["shanebdavis@imikimi.com", "jason@cumuluscode.com"]
  s.homepage    = ""
  s.summary     = %q{A gem expressing if a feature is seeded for a user}
  s.description = %q{}

  s.rubyforge_project = "sapling"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec", "~>2.7.0"
  s.add_development_dependency "mocha"
  s.add_development_dependency "activerecord", "~>3.1.1"  
  s.add_development_dependency "sqlite3", "~>1.3.4"
end
