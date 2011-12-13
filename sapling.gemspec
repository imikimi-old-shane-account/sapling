# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sapling/version"

Gem::Specification.new do |s|
  s.name        = "sapling"
  s.version     = Sapling::VERSION
  s.authors     = ["Shane Brinkman-Davis", "Jason Strutz"]
  s.email       = ["shanebdavis@imikimi.com", "jason@cumuluscode.com"]
  s.homepage    = ""
  s.summary     = %q{Incrementally roll out your features. Uses ActiveRecord to store configuration and supports client-side roll-out of cached pages.}
  s.description = %q{Sapling lets you seed your new features to just a few users at a time. You can change which and how many users are seeded for a feature dynamically by updating the database via the Sapling API. Core features are the ability to seed a feature for specific users and/or a percentage of users.}

  s.rubyforge_project = "sapling"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_runtime_dependency "activerecord", ">2.3"
  s.add_development_dependency "rspec", "~>2.7.0"
  s.add_development_dependency "rails", "2.3.12"
  s.add_development_dependency "mocha"
  s.add_development_dependency "sqlite3", "~>1.3.4"
end
