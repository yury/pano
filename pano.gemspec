require File.expand_path("../lib/pano/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "pano"
  s.version     = Pano::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Yury Korolev"]
  s.email       = ["yury.korolev@gmail.com"]
  s.homepage    = "http://github.com/yury/pano"
  s.summary     = "Just prepare photos for pano"
  s.description = "Split and fuse images for pano"
  s.date        = "2009-12-28"

  s.required_rubygems_version = ">= 1.3.6"

  # lol - required for validation
  s.rubyforge_project         = "rubyfish"

  # If you have other dependencies, add them here
  # s.add_dependency "another", "~> 1.2"

  # If you need to check in files that aren't .rb files, add them here
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", 'lib/mask.png', 'lib/mask_last.png']
  s.require_path = 'lib'

  s.executables = ["pntool"]

  # If you have C extensions, uncomment this line
  # s.extensions = "ext/extconf.rb"
end