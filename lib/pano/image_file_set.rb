module Pano

  class ImageFileSet
    
    BRACKETS = 5
    attr_reader :base_path, :files
    
    def initialize dir_path
      @base_path = dir_path
      paths = Dir[File.join(@base_path,"*.JPG")]
      @files = paths.map {|path| ImageFile.new path }
      @files.sort_by &:created_at
    end
    
    def split_images
      pano = []
      panos = []
      misc = []
      i = 0
      while i < @files.length 
        file = @files[i]
        if file.for_pano?
          if pano.length < 13 * BRACKETS
            pano << file
          else
            last = pano.last
            if (file.created_at - last.created_at) > 1.5.minutes
              panos << pano
              pano = []
            end
            pano << file
          end
        else
          if pano.present?
            panos << pano
            pano = []
          end
          misc << file
        end
        i+=1
      end
      if pano.present?
        panos << pano
      end
      [panos, misc]
    end
    
    def spit_and_copy_files apply_mask = false
      puts "analysing files..."
      panos, misc = split_images
      panos.each_with_index do |pano, index|
        pano_dir = File.join(@base_path, "pano.#{index}")
        puts "coping to #{pano_dir}"
        pano.each do |file|
          file.copy_to pano_dir
        end
        i = 0
        pano.each_slice(BRACKETS) do |files|
          i+=1
          pngs(File.join(pano_dir, "png"), "%02d" % i, files.first)
          fused = enfuse(File.join(pano_dir, "fused"), "%02d" % i, files)
          if apply_mask
            if (1..6).include? i
              system "convert #{fused} #{TOOL_ROOT}/lib/mask.png \
                        +matte -compose CopyOpacity -composite \
                        #{fused}"
            elsif i >= pano.length
              system "convert #{fused} #{TOOL_ROOT}/lib/mask_last.png \
                        +matte -compose CopyOpacity -composite \
                        #{fused}"
            end
          end
          system "mogrift -rotate -90 #{fused}"
          system "exiftool -overwrite_original -TagsFromFile #{files.first.jpg_path} #{fused}"
        end
      end
      
      misc_dir = File.join(@base_path, "misc")
      puts "coping to #{misc_dir}"
      misc.each do |file|
        file.copy_to misc_dir
      end
      
    end

    def pngs dir, name, file
      FileUtils.mkpath dir
      target = File.join(dir, name + ".png").to_s
      cmd = "convert #{file.jpg_path} #{target}"

      puts "-----------------"
      puts cmd
      puts "-----------------"
      system cmd
    end
    
    def enfuse dir, name, files = []
      return if files.blank?
      FileUtils.mkpath dir
#      contrast_weight = 0.6
#      entropy_weight = 0.4
#      exposure_weight = 0.5
#      saturation_weight = 0.2
      target = File.join(dir, name + ".tif")
      input = files.map {|file| file.jpg_path }.join(" ")
      #options = "--contrast-weight=#{contrast_weight} --entropy-weight=#{entropy_weight} --exposure-weight=#{exposure_weight} --saturation-weight=#{saturation_weight} --compression=LZW"
      options = "--compression=LZW"
      system "enfuse #{options} -o #{target} #{input}"

      target
    end
    
  end
  
end