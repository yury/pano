require 'JSON'
require 'active_support/core_ext/object'

TOOL_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))

module Pano
  autoload :Image,     'pano/image'
  autoload :ImageFile, 'pano/image_file'
  autoload :ImageFileSet, 'pano/image_file_set'
end