# frozen_string_literal: true

require_relative './lib/eskimo/version'

Gem::Specification.new do |s|
  s.name        = 'eskimo'
  s.version     = Eskimo::VERSION
  s.summary     = 'Declarative text formatting'
  s.description = 'Format text for humans using a declarative, extensible API.'
  s.author      = 'Ahmad Amireh'
  s.email       = 'ahmad@instructure.com'
  s.homepage    = 'https://github.com/amireh/eskimo'
  s.files       = Dir.glob("lib/**/*")
  s.test_files  = []
  s.license     = 'MIT'

  s.add_dependency 'eskimo-core', Eskimo::VERSION
  s.add_dependency 'eskimo-ascii', Eskimo::VERSION

  s.add_development_dependency 'rspec', '~> 3.8'
  s.add_development_dependency 'simplecov', '~> 0.16'
end
