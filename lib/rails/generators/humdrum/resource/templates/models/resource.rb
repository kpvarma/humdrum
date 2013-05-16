class <%= model_class %> < ActiveRecord::Base
  
  attr_accessible <%= fields.keys.map{|x| ":" + x.downcase }.join(", ") -%>
  
end
