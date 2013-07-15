function validate<%= model_class %>Form() {
  
    $('#form_<%= instance_name %>').validation({
        required: [
          {name: '<%= instance_name %>[first_name]'},
          {name: '<%= instance_name %>[last_name]'},
          {name: '<%= instance_name %>[designation]'},
          {
            name : '<%= instance_name %>[email]',
              // email must contain an @
            validate : function($el) {
              return $el.val().match('@') !== null;
            }
          }
        ],
        fail: function(failed) {
          errorText = "Please fill out all the required fields and ensure the data entered is valid.";
          $("#div_<%= instance_name %>_form_error").remove();
          txtDiv = "<div id='div_<%= instance_name %>_form_error' class=\"alert danger\" data-alert=\"alert\" style=\"margin-bottom:5px;\">"+ errorText +"</div>"
          $("#div_<%= instance_name %>_details").prepend(txtDiv);
        },
        submit: function(data) {
          $.ajax({
            url: $("#form_<%= instance_name %> input[name=faction]").val(),
            type: $("#form_<%= instance_name %> input[name=fmethod]").val(),
            dataType: 'script',
            data: data
          });
        }
    });
    
}
