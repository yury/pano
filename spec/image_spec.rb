require 'spec_helper'

describe Pano::Image do
  include Pano::Image
  
  before :all do
    @cannon_info = read_info "#{TOOL_ROOT}/spec/fixtures/from_cannon_camera.JPG"
    @nikon_info = read_info "#{TOOL_ROOT}/spec/fixtures/from_nikon_camera.JPG"
  end
  
  it "should read bracketing info from canon files" do
    @cannon_info["BracketMode"].should == "AEB"
    @cannon_info["BracketValue"].should == 0
    @cannon_info["BracketShotNumber"].should == 0
  end

  it "should read bracketing info from nikon files" do
    @nikon_info["ExposureBracketValue"].should == 0
  end
  
  it "should detect lens type" do
    @cannon_info["LensType"].should == "Canon EF 20-35mm f/3.5-4.5 USM or Tamron Lens"
    @cannon_info["LensModel"].should == "10-17mm"
    @cannon_info[:fov].should == 97.3
  end
  
  it "should read orientation" do
    @cannon_info["Orientation"].should == "Rotate 270 CW"
    @nikon_info["Orientation"].should == "Rotate 270 CW"
  end

end