/*Display the number of new enquiries in the drop down list*/

function newEnquiries(place) {
	$.get("/profile/new", function(data){
		var enquiry;
		enquiry = "Enquiries";
		
		if (data > 0)
			enquiry += " ("+ data + ") ";
		
		if (place == "enquiries")
			$("#enquiries").html(enquiry);
		else
			$("#enquiryLink").html(enquiry);
	});
}