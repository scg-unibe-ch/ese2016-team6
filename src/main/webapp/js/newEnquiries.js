/*Display the number of new enquiries in the drop down list*/

function newEnquiries(place) {
	$.get("/profile/newEnquiries", function(data){
		var enquiry;
		$("#enquiryLink").html(data + " " + enquiry);
	});
}