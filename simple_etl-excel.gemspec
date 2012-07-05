# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "simple_etl/excel/version"

Gem::Specification.new do |s|
  s.name        = "simple_etl-excel"
  s.version     = SimpleEtl::Excel::VERSION
  s.authors     = ["Nicola Racco"]
  s.email       = ["nicola@nicolaracco.com"]
  s.homepage    = "https://github.com/nicolaracco/simple_etl-excel"
  s.summary     = %q{Excel Format Plugin for SimpleETL}
  s.description = %q{Excel Format Plugin for SimpleETL}

  s.rubyforge_project = "simple_etl-excel"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  #s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rake'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'growl'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'rspec'

  s.add_runtime_dependency "simple_etl", "~> 0.0.2"
  s.add_runtime_dependency "spreadsheet", "~> 0.7"
end
