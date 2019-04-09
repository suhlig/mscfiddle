
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mscfiddle/version"

Gem::Specification.new do |spec|
  spec.name          = "mscfiddle"
  spec.version       = MscFiddle::VERSION
  spec.authors       = ["Steffen Uhlig"]
  spec.email         = ["Steffen.Uhlig@de.ibm.com"]

  spec.summary       = %q{Fiddle with message sequence charts (msc)}
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'guard-livereload'
  spec.add_dependency 'guard-shell'
  spec.add_dependency 'rack-livereload'
  spec.add_dependency 'sinatra'
  spec.add_dependency 'sinatra-partial'
  spec.add_dependency 'thin'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'guard-minitest'
  spec.add_development_dependency 'guard-bundler'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rerun'
  spec.add_development_dependency 'pry-byebug'
end
