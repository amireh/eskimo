# frozen_string_literal: true

require_relative './lib/eskimo/ascii/version'

Gem::Specification.new do |s|
  s.name        = 'eskimo-ascii'
  s.version     = Eskimo::ASCII::VERSION
  s.summary     = 'Declarative text formatting'
  s.description = 'Format text for humans using a declarative, extensible API.'
  s.author      = 'Ahmad Amireh'
  s.email       = 'ahmad@instructure.com'
  s.homepage    = 'https://github.com/amireh/eskimo'
  s.files       = Dir.glob("lib/**/*")
  s.test_files  = Dir.glob("spec/**/*")
  s.license     = 'MIT'

  s.add_dependency 'eskimo-core', '~> 4.0'
  s.add_dependency 'pastel', '~> 0.7'
  s.add_dependency 'strings', '~> 0.1'
  s.add_dependency 'tty-screen', '~> 0.6'

  s.add_development_dependency 'rspec', '~> 3.8'
  s.add_development_dependency 'simplecov', '~> 0.16'
end
