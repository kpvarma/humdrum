module ImageHelper
  
  def display_image(object, photo_association_name=:photo, width=80)
    
    if width.is_a?(String)
      if width.include?("px")
        width_val = width.split("px").first
      elsif width.include?("%")
        width_val = width.split("%").first
      else
        width_val = width.to_i
      end
      width_string = width
    else
      width_val = width
      width_string = "#{width.to_i}px"
    end
    
    if object.respond_to?(photo_association_name) && object.send(photo_association_name)
      return image_tag object.send(photo_association_name).image_url, :style=>"width:#{width_string};"
    else
      return image_tag "http://placehold.it/#{width_val}x#{width_val}", :class=>"img-thumbnail"
    end
  end  
  
  def display_photo(photo, width=100)
    return image_tag photo.image_url, :style=>"width:#{width}px;", :width=>"#{width}", :class=>"img-thumbnail"
  end
  
end
