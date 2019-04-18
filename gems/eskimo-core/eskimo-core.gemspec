# frozen_string_literal: true

require_relative './lib/eskimo/core/version'

Gem::Specification.new do |s|
  s.name        = 'eskimo-core'
  s.version     = Eskimo::Core::VERSION
  s.summary     = 'Declarative text formatting'
  s.description = 'Format text for humans using a declarative, extensible API.'
  s.author      = 'Ahmad Amireh'
  s.email       = 'ahmad@instructure.com'
  s.homepage    = 'https://github.com/amireh/eskimo'
  s.files       = Dir.glob("lib/**/*")
  s.test_files  = Dir.glob("spec/**/*")
  s.license     = 'MIT'

  s.required_ruby_version = '>= 2.4'

  s.add_development_dependency 'rspec', '~> 3.8'
  s.add_development_dependency 'simplecov', '~> 0.16'
end
