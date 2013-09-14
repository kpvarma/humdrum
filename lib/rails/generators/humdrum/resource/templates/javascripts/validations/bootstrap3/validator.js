function validate<%= model_class %>Form() {
  
    $('#form_<%= instance_name %>').validate({
      debug: true,
      rules: {
      <%- fields.each do |name, type| -%>
      <%- input_type = guess_input_type(name, type) -%>
      <%- if input_type == "email" -%>
        "<%= instance_name %>[email]": {
            required: true,
            email: true
        },
      <%- elsif input_type == "text" -%>
        "<%= instance_name %>[<%= name %>]": {
            required: true,
            minlength: 2,
            maxlength: 50
        },
      <%- else -%>
        "<%= instance_name %>[<%= name %>]": "required",
      <%- end -%>
      <%- end -%>
      },
      errorElement: "span",
      errorClass: "help-block",
      messages: {
      <%- fields.each do |name, type| -%>
      <%- input_type = guess_input_type(name, type) -%>
      <%- if input_type == "email" -%>
        "<%= instance_name %>[<%= name %>]": {
            required: "We need your email address to contact you",
            email: "Your email address must be in the format of name@domain.com"
        },
      <%- elsif input_type == "text" -%>
        "<%= instance_name %>[<%= name %>]": "Please specify <%= name.titleize %>",
      <%- else -%>
        "<%= instance_name %>[<%= name %>]": "Please specify <%= name.titleize %>",
      <%- end -%>
      <%- end -%>
      },
      highlight: function(element) {
          $(element).parent().parent().addClass("has-error");
      },
      unhighlight: function(element) {
          $(element).parent().parent().removeClass("has-error");
      },
      invalidHandler: function(event, validator) {
        // 'this' refers to the form
        var errors = validator.numberOfInvalids();
        if (errors) {
          
          // Populating error message
          var errorMessage = errors == 1
            ? 'You missed 1 field. It has been highlighted'
            : 'You missed ' + errors + ' fields. They have been highlighted';
          
          // Removing the form error if it already exists
          $("#div_<%= instance_name %>_js_validation_error").remove();
          
          errorHtml = "<div id='div_<%= instance_name %>_js_validation_error' class=\"alert alert-danger\" data-alert=\"alert\" style=\"margin-bottom:5px;\">"+ errorMessage +"</div>"
          //$("#div_<%= instance_name %>_details").prepend(errorHtml);  
          $("#div_modal_generic div.modal-body-main").prepend(errorHtml);  
          
          // Show error labels
          $("div.error").show();
          
        } else {
          // Hide error labels
          $("div.error").hide();
          // Removing the error message
          $("#div_<%= instance_name %>_js_validation_error").remove();
        }
      }
      
    });
    
}
