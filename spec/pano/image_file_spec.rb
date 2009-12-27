require 'spec_helper'
require 'pano'

include Pano
describe ImageFile do

  before :all do
    @file_1 = ImageFile.new "#{TOOL_ROOT}/spec/fixtures/from_camera.JPG"
    @file_b = ImageFile.new "#{TOOL_ROOT}/spec/fixtures/from_camera_bottom.JPG"
    
    # @file_last_from_pano_1 = ImageFile.new "#{TOOL_ROOT}/spec/fixtures/33/IMG_3244.JPG"
    # @file_first_from_pano_2 = ImageFile.new "#{TOOL_ROOT}/spec/fixtures/33/IMG_3245.JPG"
  end
  
  it "should read bracketing info" do
    @file_1.should be_bracketed
    @file_b.should be_bracketed
    
    @file_1.bracketing_number.should == 0
    @file_b.bracketing_number.should == 1
  end
  
  it "should detect files for pano" do
    @file_1.should be_for_pano
    @file_b.should be_for_pano
    
    # @file_last_from_pano_1.info.each_pair do |key, value|
    #   b_value = @file_first_from_pano_2.info[key]
    #   if value != b_value
    #     puts "def in '#{key}' #{value} != #{b_value}"
    #   end
    # end
    
    # puts @file_first_from_pano_2.created_at - @file_last_from_pano_1.created_at
    # puts (@file_first_from_pano_2.created_at - @file_last_from_pano_1.created_at).class
    # puts (@file_first_from_pano_2.created_at - @file_last_from_pano_1.created_at) > 1.5.minutes
  end
  
end