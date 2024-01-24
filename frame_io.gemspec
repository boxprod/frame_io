require_relative "lib/frame_io/version"

Gem::Specification.new do |spec|
  spec.name        = "frame_io"
  spec.version     = FrameIo::VERSION
  spec.authors     = ["Victor Holl"]
  spec.email       = ["v_h@me.com"]
  spec.homepage    = "https://github.com/boxprod/frame_io"
  spec.summary     = "Basic API Wrapper for Frame.io using OAuth2"
  spec.description = "Basic and WIP API wrapper for Frame.io. Uses OAuth2 and omniauth-frameio strategy gem."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/boxprod/frame_io"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency 'omniauth-frameio'
  spec.add_dependency "rails", ">= 7.1.2"
end
