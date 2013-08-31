// Write down only those functions which are being used by application.init or any part of the application like ajax event handlers.

// loadANewPage will accept a url and will load a new page
// It can be tuned to show a lightbox showing a loading, please wait message.
function loadANewPage(url){
	// showLightBoxLoading();
	window.location.href=url;
}

// sendAjaxRequest is used to send an xml http request using javascript to a url using a method / get, put, post, delete
function sendAjaxRequest(url, mType){
	methodType = mType || "GET";
	jQuery.ajax({type: methodType, dataType:"script", url:url});
}

// Call this function by passing a heading and a body message.
// it will pop up bootstrap modal with the message.
function showMessageInThePopUp(heading, message){
	$('#div-modal-popup-message .modal-body').html("<p>"+ message +"</p>");
	$("#h3-modal-popup-message-header").text(heading);
	$('#div-modal-popup-message').modal('show');
	$(".btn").button('reset')
}