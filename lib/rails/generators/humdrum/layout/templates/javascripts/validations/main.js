function populateServerSideErrors(instanceName, errorMessages) {
  
  // Removing the old server validation errors if any
  $("#div_"+ instanceName +"_server_validation_errors").remove();
  
  // Creating a div to hold multiple error messages.
  errorMessageHolder = "<div id='div_"+ instanceName +"_server_validation_errors' style=\"margin-bottom:5px;\"></div>"
  $("#div_"+ instanceName +"_details").prepend(errorMessageHolder);
  
  jQuery.each(errorMessages, function(i, message) {
    errorHtml = "<div class=\"alert danger\" data-alert=\"alert\" style=\"margin-bottom:5px;\">"+ message +"</div>"
    $("#div_"+ instanceName +"_server_validation_errors").prepend(errorHtml);
   });
  
}
