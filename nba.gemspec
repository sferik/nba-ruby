require_relative "lib/nba/version"

Gem::Specification.new do |spec|
  spec.name = "nba"
  spec.version = NBA::VERSION
  spec.authors = ["Erik Berlin"]
  spec.email = "sferik@gmail.com"

  spec.summary = "A Ruby interface to the NBA Stats API."
  spec.homepage = "https://sferik.github.io/nba-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2"
  spec.platform = Gem::Platform::RUBY

  spec.add_dependency "equalizer", "~> 0.0.11"
  spec.add_dependency "shale", "~> 1.2"

  spec.metadata = {
    "allowed_push_host" => "https://rubygems.org",
    "bug_tracker_uri" => "https://github.com/sferik/nba-ruby/issues",
    "changelog_uri" => "https://github.com/sferik/nba-ruby/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://rubydoc.info/gems/nba/",
    "funding_uri" => "https://github.com/sponsors/sferik/",
    "homepage_uri" => spec.homepage,
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/sferik/nba-ruby"
  }

  spec.files = Dir[
    "bin/*",
    "lib/**/*.rb",
    "sig/*.rbs",
    "*.md",
    "LICENSE"
  ]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
