# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'octopress-codefence/version'

Gem::Specification.new do |gem|
  gem.name          = "octopress-codefence"
  gem.version       = Octopress::Codefence::VERSION
  gem.authors       = ["Brandon Mathis"]
  gem.email         = ["brandon@imathis.com"]
  gem.description   = %q{Write beautiful fenced code snippets with in any template.}
  gem.summary       = %q{Write beautiful fenced code snippets with in any template.}
  gem.homepage      = "https://github.com/octopress/codefence"
  gem.license       = "MIT"

  gem.add_runtime_dependency 'octopress-pygments', '>= 2.0.0'
  gem.add_runtime_dependency 'jekyll-page-hooks', '>= 1.0.2'

  gem.files         = `git ls-files`.split($/)
  gem.require_paths = ["lib"]
end
