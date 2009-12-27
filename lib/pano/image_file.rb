module Pano
  class ImageFile
    include Image
    
    attr_reader :jpg_path, :raw_path, :info
    
    def initialize path
      if path =~ /\.jpg$/i
        @jpg_path = path
        @raw_path = path.sub(/\.jpg$/i, ".CR2")
      else
        @raw_path = path
        @jpg_path = path.sub(/\.cr2$/i, ".JPG")
      end
      
      if File.exist?(@jpg_path)
        @info = read_info(@jpg_path)
      elsif File.exist?(raw_path)
        @info = read_info(@raw_path)
      else
        raise "File not found '#{path}'"
      end
    end
    
    def for_pano?
      @for_pano ||= @info[:fov] > 95 && @info["SelfTimer"] == "2 s" && @info["Orientation"] == "Rotate 270 CW"
    end
    
    def bracketed?
      @bracketed ||= @info["BracketMode"] == "AEB" && @info["BracketShotNumber"] == 0
    end
    
    def bracketing_number
      b = @info["BracketValue"]
      b == 0 ? 0 : b < 0 ? 1 : 2
    end
    
    def list_info
      @info.each_pair do |k, v|
        puts "#{k} - #{v}"
      end
    end
    
    def created_at
      @created_at ||= @info[:created_at]
    end
    
    def copy_to dest_dir
      FileUtils.mkpath dest_dir;
      FileUtils.cp(@raw_path, dest_dir) if File.exist?(@raw_path)
      FileUtils.cp(@jpg_path, dest_dir) if File.exist?(@jpg_path)
    end
    
  end
end