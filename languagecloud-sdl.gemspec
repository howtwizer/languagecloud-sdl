# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'languagecloud-sdl/version'

Gem::Specification.new do |spec|
  spec.name          = 'languagecloud-sdl'
  spec.version       = LanguagecloudSdl::API::VERSION
  spec.authors       = ["Alex Baidan"]
  spec.email         = ["howtwizer@gmail.com"]


  spec.summary       = %q{Ruby connector for https://languagecloud.sdl.com translate service}
  spec.homepage      = "https://github.com/howtwizer/languagecloud-sdl"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency('json')
  spec.add_dependency('httparty')
  spec.add_dependency('activesupport')
  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency('rspec')
  spec.add_development_dependency('rspec-its')
  spec.add_development_dependency('webmock', '~> 1.22')
  spec.add_development_dependency('pry')
  spec.add_development_dependency('pry-byebug')
end
