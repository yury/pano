require 'spec_helper'
require 'pano'

describe Pano::Image do
  include Pano::Image
  
  before :all do
    @info = read_info "#{TOOL_ROOT}/spec/fixtures/from_camera.JPG"
  end
  
  it "should read bracketing info" do
    @info["BracketMode"].should == "AEB"
    @info["BracketValue"].should == 0
    @info["BracketShotNumber"].should == 0
  end
  
  it "should detect lens type" do
    @info["LensType"].should == "Canon EF 20-35mm f/3.5-4.5 USM"
    @info["LensModel"].should == "10-17mm"
    @info[:fov].should == 97.3
  end
  
  it "should read orientation" do
    @info["Orientation"].should == "Rotate 270 CW"
  end
  
  # it "should list attributes" do
  #     @info.each_pair do |k, v| 
  #       puts "#{k}, #{v}"
  #     end
  #   end
end