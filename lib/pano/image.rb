require 'fileutils'

module Pano
  module Image

    def read_info file_path
      json = `exiftool -d "%Y-%m-%d %H:%M:%S %z" -j "#{file_path}" 2>&1`

      return {:error => "File not found"} if json =~ /^File not found/i  

      data = JSON.parse(json)[0]
      data[:width]            = data["ImageWidth"]
      data[:height]           = data["ImageHeight"]
      data[:size]             = data["ImageSize"]
      data[:file_size]        = data["FileSize"]
      data[:camera_model]     = data["Model"]
      data[:keywords]         = data["Keywords"] || ""
      data[:owner_name]       = data["OwnerName"]  # camera owner. 
      data[:iptc_digest]      = data["IPTCDigest"] # thinking this can be used to detect photographers if OwnerName undefined
      data[:created_at]       = try_parse_date data, "CreateDate"
      data[:modified_at]      = try_parse_date data, "ModifyDate"
      data[:file_modified_at] = try_parse_date data, "FileModifyDate"
      data[:orientation]      = data[:width] > data[:height] ? 'h' : 'v'
      data[:fov]              = data["FOV"].to_f

      if data["PhotoshopQuality"].present?
        quality = data["PhotoshopQuality"]
        data[:quality] = quality <= 9 ? quality * 10 : quality
      end

      data
    end
    
    private

    def try_parse_date data, key
      s = data[key]
      s.blank? ? nil : Time.parse(s)
    end

    def normalize_thumb_options options={}
      options.reverse_merge(default_thumb_options)
    end

    def suffix_based_on_options opts
      suffix = "#{opts[:size]}q#{opts[:quality]}"
      suffix << 'w'   if opts[:watermarked]
      suffix << 'f'   if opts[:force]
      suffix << 'p'   if opts[:protected]
      suffix << "cbt#{opts[:crop_before_to]}" if opts[:crop_before_to]
      suffix << 'lo'  if opts[:flop]
      suffix << 'li'  if opts[:flip]
      suffix << 'dne' if opts[:do_not_enlarge]
      suffix << 't'   if opts[:top]
      suffix
    end
  end
end
