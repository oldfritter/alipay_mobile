# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "alipay_mobile/version"

Gem::Specification.new do |spec|
  spec.name          = "alipay_mobile"
  spec.version       = AlipayMobile::VERSION
  spec.authors       = ["Leon"]
  spec.email         = ["leon.zcf@gmail.com"]
  spec.description   = %q{An unofficial simple alipay gem}
  spec.summary       = %q{An unofficial simple alipay gem}
  spec.homepage      = "https://github.com/oldfritter/alipay_mobile"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "nokogiri", '~> 1.11.4'
  spec.add_development_dependency "fakeweb"
end
