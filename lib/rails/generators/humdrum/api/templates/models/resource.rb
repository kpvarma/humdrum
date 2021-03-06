class <%= model_class %> < ActiveRecord::Base

  #attr_accessible <%= fields.keys.map{|x| ":" + x.downcase }.join(", ") %>

  # Validations
  <%- fields.each do |name, type| -%>
    <%- if type == "string" %>
  #validates :<%= name %>, :presence=>true
    <%- elsif type == "text" %>
  #validates :<%= name %>, :presence=>true
    <%- elsif type == "integer" %>
  #validates :<%= name %>, :presence=>true, :numericality => true, :if => proc{|x| x.condition? }
    <%- elsif type == "decimal" || type == "float" %>
  #validates :<%= name %>, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ },
:numericality =>{:greater_than => 0}
    <%- elsif type != "boolean" %>
  #validates :<%= name %>, :presence=>true
    <%- end -%>
  <%- end -%>

  # Validation Examples
  #LANDLINE_LIST = ["1234567890", "0987654321"]
  #validates :first_name,
  #           :presence=>true,
  #           :length => {:minimum => ConfigCenter::GeneralValidations::FIRST_NAME_MIN_LEN ,
  #           :maximum => ConfigCenter::GeneralValidations::FIRST_NAME_MAX_LEN, :message => "should be less than x and greater than y"},
  #           :uniqueness => {:scope => [:user_id, :status], :case_sensitive => false},
  #           :format => {:with => ConfigCenter::GeneralValidations::FIRST_NAME_FORMAT_REG_EXP, :message => "Invalid format"},
  #           :inclusion => { :in => PHONE_LIST, :message => "not included in the list" },
  #           :unless => proc{|user| user.password.blank? }

end
