require 'spec_helper'
require 'pano'

include Pano

describe ImageFileSet do
  
  it "should read directory" do
    set = ImageFileSet.new "#{TOOL_ROOT}/spec/fixtures/"
    set.files.length.should == 3
  end
  
  # it "should split images" do
  #   set = ImageFileSet.new "#{TOOL_ROOT}/spec/fixtures/33"
  #   panos, misc = set.split_images
  #   puts panos.length
  #   puts misc.length
  # end
  
  it "should split and copy files" do
    set = ImageFileSet.new "#{TOOL_ROOT}/spec/fixtures/hrap"
    set.spit_and_copy_files
  end
  
end