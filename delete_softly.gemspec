# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "version"

Gem::Specification.new do |s|
  s.name        = "delete_softly"
  s.version     = DeleteSoftly::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Benjamin ter Kuile", "Coroutine", "John Dugan"]
  s.email       = ["gems@coroutine.com"]
  s.homepage    = "http://github.com/coroutine/delete_softly"
  s.summary     = %q{This gem adds soft delete functionality to your ActiveRecord models.}
  s.description = %q{This gem adds soft delete functionality to your ActiveRecord models.}
  
  s.add_dependency "rails", ">= 3.0.0"
  
  s.add_development_dependency "rspec", ">= 2.0.0"
  
  s.rubyforge_project = "delete_softly"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

