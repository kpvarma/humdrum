module ImageHelper
  
  def display_image(object, width=80, height=80)
    if object.respond_to?(:photo) && object.send(:photo)
      return image_tag object.photo.image_url, :style=>"width:#{width}px;height:#{height}px;", :height=>"#{height}", :width=>"#{width}"
    else
      return image_tag "http://placehold.it/#{width}x#{height}"
    end
  end
  
  
end
