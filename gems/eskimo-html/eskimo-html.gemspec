# frozen_string_literal: true

require_relative './lib/eskimo/html/version'

Gem::Specification.new do |s|
  s.name        = 'eskimo-html'
  s.version     = Eskimo::HTML::VERSION
  s.summary     = 'Declarative HTML formatting'
  s.description = 'Render HTML using a declarative, extensible API.'
  s.author      = 'Ahmad Amireh'
  s.email       = 'ahmad@instructure.com'
  s.homepage    = 'https://github.com/amireh/eskimo'
  s.files       = Dir.glob("lib/**/*")
  s.test_files  = Dir.glob("spec/**/*")
  s.license     = 'MIT'

  s.add_dependency 'eskimo-core', Eskimo::HTML::VERSION

  s.add_development_dependency 'rspec', '~> 3.8'
  s.add_development_dependency 'simplecov', '~> 0.16'
end
