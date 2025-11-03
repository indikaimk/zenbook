require_relative "lib/zenbook/version"

Gem::Specification.new do |spec|
  spec.name        = "zenbook"
  spec.version     = Zenbook::VERSION
  spec.authors     = [ "cloudqubes" ]
  spec.email       = [ "cloud.qubes@gmail.com" ]
  spec.homepage    = "https://github.com/indikaimk/zenbook"
  spec.summary     = "A Rails engine for writing books"
  spec.description = "Write and publish books with ease"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "http://mygemserver.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/indikaimk/zenbook"
  spec.metadata["changelog_uri"] = "https://github.com/indikaimk/zenbook/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 8.1.0"
end
