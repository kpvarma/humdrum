class <%= layout_name.camelize %>Controller < ApplicationController
  
  layout '<%= layout_name.underscore %>'
  
end
