#-*- ruby -*-
# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'post-images-bot/version'

Gem::Specification.new do |spec|
  spec.name     = 'post-images-bot'
  spec.version  = PostImagesBot::VERSION
  spec.authors  = ['Karl-Johan Karlsson']
  spec.email    = ['creideiki@ferretporn.se']
  spec.summary	= 'Twitter bot for automatically posting images'
  spec.description = spec.summary
  spec.homepage    = 'https://github.com/creideiki/post-images-bot'
  spec.license	= 'GPL-2.0+'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features|examples|tools)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.platform	= Gem::Platform::RUBY
  spec.required_ruby_version = '~>2'

  spec.add_runtime_dependency 'twitter', '~>6'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.46'

  spec.has_rdoc	= true
end
