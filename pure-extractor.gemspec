# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pure/extractor/version'

Gem::Specification.new do |spec|
  spec.name          = "pure-extractor"
  spec.version       = Pure::Extractor::VERSION
  spec.authors       = ["Stephen Robinson", "LULibrary"]
  spec.email         = ["library.dit@lancaster.ac.uk"]

  spec.summary       = %q{Command line application to extract data from Pure and write to JSON files for DMAO}
  spec.description   = %q{Command line application to extract data from Pure and write to JSON files for DMAO}
  spec.homepage      = "https://github.com/lulibrary"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "clamp"
  spec.add_dependency "puree"

  spec.add_dependency "bundler", "~> 1.12"
  
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
