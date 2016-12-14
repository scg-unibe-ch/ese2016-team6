function messageEnquiries(place) {
	$.get("/profile/getMessageAndEnquiries", function(data){ 
		$.get("/profile/getUsername", function(data2) {
			if(data==0)
				$("#messageEnquiryLink").html(data2);
			else
				$("#messageEnquiryLink").html(data2 + " " + "(" + data + ")");
		});
	});
}