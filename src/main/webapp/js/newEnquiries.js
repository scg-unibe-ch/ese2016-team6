function newEnquiries(place) {
	$.get("/profile/newE", function(data){
		var enquiry;
		if (place == "enquiries")
			enquiry = "Enquiries";
		else
			enquiry = "Enquiries";
		if (data > 0)
			enquiry += " ("+ data + ") ";
		if (place == "enquiries")
			$("#enquiries").html(enquiry);
		else
			$("#enquiryLink").html(enquiry);
	});
}