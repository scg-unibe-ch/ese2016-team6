function messageEnquiries(place) {
	$.get("/profile/getMessageAndEnquiries", function(data){ 
		$.get("/profile/getUsername", function(data2) {
			$("#messageEnquiryLink").html(data2 + " " + "(" + data + ")");
		});
	});
}