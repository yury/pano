require 'spec_helper'

include Pano
describe ImageFile do

  before :all do
    @file_n = ImageFile.new "#{TOOL_ROOT}/spec/fixtures/from_nikon_camera.JPG"
  end
  
  it "should read bracketing info" do
    @file_n.should be_bracketed
  end
  
  it "should detect files for pano" do
    @file_n.should be_for_pano
  end
  
end