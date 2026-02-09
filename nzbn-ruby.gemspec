# frozen_string_literal: true

require_relative 'lib/nzbn/version'

Gem::Specification.new do |spec|
  spec.name          = 'nzbn-ruby'
  spec.version       = Nzbn::VERSION
  spec.authors       = ['Nhan Nguyen']
  spec.email         = ['nnhansg@gmail.com']

  spec.summary       = 'Ruby client for the New Zealand Business Number (NZBN) API'
  spec.description   = 'A Ruby gem for interacting with the NZBN API v5. Search entities, manage watchlists, and access NZ business data.'
  spec.homepage      = 'https://github.com/nnhansg/nzbn-ruby'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.files += Dir['lib/**/*.rb']
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 1.0'
  spec.add_dependency 'json', '~> 2.1'

  spec.add_development_dependency 'bundler', '>= 1.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 3.0'
end
