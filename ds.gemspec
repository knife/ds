# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'ds/version'

Gem::Specification.new do |s|
  s.name        = 'ds'
  s.version     = DS::VERSION
  s.authors     = ['knife']
  s.email       = ['satre@o2.pl']
  s.homepage    = ''
  s.summary     = 'Some common data structures.'
  s.description = 'Data structures (lists, stacks, trees, heaps, graphs..) in pure Ruby.'
  s.rubyforge_project = 'ds'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'minitest'
end
