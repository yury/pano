# -*- encoding: utf-8 -*-
require 'rake'

Gem::Specification.new do |s|
  s.name = %q{pano}
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.5") if s.respond_to? :required_rubygems_version=
  s.authors = ["Yury Korolev"]
  s.date = %q{2009-12-28}
  s.description = %q{Split and fuse images for pano}
  s.email = ["yury.korolev@gmail.com"]
  s.files = FileList['lib/**/*.rb', 'bin/*', 'lib/mask.png', 'lib/mask_last.png'].to_a
  s.homepage = %q{http://anjlab.com}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{"Just prepare photos for pano"}
  s.has_rdoc = false
  s.executables = ['pntool']
  s.add_dependency('activesupport', '>= 2.3.5')

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
