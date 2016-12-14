/*Display the number of new enquiries in the drop down list*/

function newEnquiries(place) {
	$.get("/profile/newEnquiries", function(data){
		var enquiry;
		if(data==0)
			$("#enquiryLink").html("Enquiries");
		else
			$("#enquiryLink").html("Enquiries ("+ data + ")" );
	});
}