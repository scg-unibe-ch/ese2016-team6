<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:import url="template/header.jsp" />

<script src="/js/jquery.ui.widget.js"></script>
<script src="/js/jquery.iframe-transport.js"></script>
<script src="/js/jquery.fileupload.js"></script>
<script src="/js/pictureUpload.js"></script>

<script>
	$(document).ready(function() {
		
		// Go to controller take what you need from user
		// save it to a hidden field
		// iterate through it
		// if there is id == x then make "Bookmark Me" to "bookmarked"

		
		
		//document.getElementById('type-sale').checked="";
		//document.getElementById('type-auction').checked="";
		
		document.getElementById('field-priceRent').style.visibility = "visible";
		document.getElementById('field-priceSale').style.visibility = "hidden";
		document.getElementById('field-currentBid').style.visibility = "hidden";
		document.getElementById('field-increment').style.visibility = "hidden";
		document.getElementById('field-deadlineDate').style.visibility = "hidden";
		document.getElementById('field-deadlineHour').style.visibility = "hidden";
		document.getElementById('field-deadlineMinute').style.visibility = "hidden";
		
		document.getElementById('rentLabel').style.visibility = "visible";
		document.getElementById('saleLabel').style.visibility = "hidden";
		document.getElementById('bidLabel').style.visibility = "hidden";
		document.getElementById('incLabel').style.visibility = "hidden";
		document.getElementById('deadLabel').style.visibility = "hidden";
		
		
		document.getElementById('ActualDeal').value = "forRent";
		
		

    	$("#type-rent").on("click", function(){
			document.getElementById('type-sale').checked="";
			document.getElementById('type-auction').checked="";
        	document.getElementById('field-priceRent').style.visibility = "visible";
        	document.getElementById('field-priceSale').style.visibility = "hidden";
        	document.getElementById('field-currentBid').style.visibility = "hidden";
        	document.getElementById('field-increment').style.visibility = "hidden";
			document.getElementById('field-deadlineDate').style.visibility = "hidden";
			document.getElementById('field-deadlineHour').style.visibility = "hidden";
			document.getElementById('field-deadlineMinute').style.visibility = "hidden";
			
			document.getElementById('rentLabel').style.visibility = "visible";
			document.getElementById('saleLabel').style.visibility = "hidden";
			document.getElementById('bidLabel').style.visibility = "hidden";
			document.getElementById('incLabel').style.visibility = "hidden";
			document.getElementById('deadLabel').style.visibility = "hidden";
			
			
			document.getElementById('ActualDeal').value = "forRent";
			
			document.getElementById('preference').style.visibility = "visible";
			
    	});

		$("#type-sale").on("click", function(){
			document.getElementById('type-rent').checked="";
			document.getElementById('type-auction').checked="";
			document.getElementById('field-priceRent').style.visibility = "hidden";
        	document.getElementById('field-priceSale').style.visibility = "visible";
        	document.getElementById('field-currentBid').style.visibility = "hidden";
        	document.getElementById('field-increment').style.visibility = "hidden";
			document.getElementById('field-deadlineDate').style.visibility = "hidden";
			document.getElementById('field-deadlineHour').style.visibility = "hidden";
			document.getElementById('field-deadlineMinute').style.visibility = "hidden";
			
			
			document.getElementById('rentLabel').style.visibility = "hidden";
			document.getElementById('saleLabel').style.visibility = "visible";
			document.getElementById('bidLabel').style.visibility = "hidden";
			document.getElementById('incLabel').style.visibility = "hidden";
			document.getElementById('deadLabel').style.visibility = "hidden";
			
			document.getElementById('ActualSale').value = "direct";
			document.getElementById('ActualDeal').value = "forSale";
			
				document.getElementById('preference').style.visibility = "hidden";
   		});

    	$("#type-auction").on("click", function(){
    		document.getElementById('type-rent').checked="";
			document.getElementById('type-sale').checked="";
			document.getElementById('field-priceRent').style.visibility = "hidden";
        	document.getElementById('field-priceSale').style.visibility = "visible";
        	document.getElementById('field-currentBid').style.visibility = "visible";
        	document.getElementById('field-increment').style.visibility = "visible";
			document.getElementById('field-deadlineDate').style.visibility = "visible";
			document.getElementById('field-deadlineHour').style.visibility = "visible";
			document.getElementById('field-deadlineMinute').style.visibility = "visible";
			
			
			document.getElementById('rentLabel').style.visibility = "hidden";
			document.getElementById('saleLabel').style.visibility = "visible";
			document.getElementById('bidLabel').style.visibility = "visible";
			document.getElementById('incLabel').style.visibility = "visible";
			document.getElementById('deadLabel').style.visibility = "visible";
			
			document.getElementById('ActualSale').value = "bothAuctionAndDirect";
			document.getElementById('ActualDeal').value = "forSale";
			
				document.getElementById('preference').style.visibility = "hidden";
    	});

		$("#field-city").autocomplete({
			minLength : 2
		});
		
		$("#field-city").autocomplete({
			source : <c:import url="getzipcodes.jsp" />
		});
		
		$("#field-city").autocomplete("option", {
			enabled : true,
			autoFocus : true
		});
		
		$("#field-moveInDate").datepicker({
			minDate: '0' , dateFormat : 'dd-mm-yy'
		});
		
		$("#field-moveOutDate").datepicker({
			minDate: '0' , dateFormat : 'dd-mm-yy'
		});
		
		$("#field-visitDay").datepicker({
			minDate: '0' , dateFormat : 'dd-mm-yy'
		});
		
		$("#field-deadlineDate").datepicker({
			minDate: '0' , dateFormat : 'dd-mm-yy'
		});
		
		$("#addbutton").click(function() {
			
			var text = $("#roomFriends").val();
			var alreadyAdded = $("#addedRoommates").html();
			
			if(validateForm(text)) {
				$.post("/profile/placeAd/validateEmail",{email: text, alreadyIn: alreadyAdded}, function(data) {
					if(validateForm(data)) {
						var index = $("#roommateCell input.roommateInput").length;
						$("#roommateCell").append("<input class='roommateInput' type='hidden' name='registeredRoommateEmails[" + index + "]' value='" + data + "' />");
						$("#addedRoommates").append(data + "; ");
					} else {
						alert(data);
					}});
			}
			
			else {
				alert("Please enter an e-mail adress");
			}
			  
			 
			// Validates the input for Email Syntax
			function validateForm(text) {
			    var positionAt = text.indexOf("@");
			    var positionDot = text.lastIndexOf(".");
			    if (positionAt< 1 || positionDot<positionAt+2 || positionDot+2>=text.length) {
			        return false;
			    } else {
			    	return true;
			    }
			}
		});
		
		
		
		
		$("#addVisitButton").click(function() {
			var date = $("#field-visitDay").val();
			if(date == ""){
				return;
			}
			
			var startHour = $("#startHour").val();
			var startMinutes = $("#startMinutes").val();
			var endHour = $("#endHour").val();
			var endMinutes = $("#endMinutes").val();
			
			if (startHour > endHour) {
				alert("Invalid times. The visit can't end before being started.");
				return;
			} else if (startHour == endHour && startMinutes >= endMinutes) {
				alert("Invalid times. The visit can't end before being started.");
				return;
			}
			
			var newVisit = date + ";" + startHour + ":" + startMinutes + 
				";" + endHour + ":" + endMinutes; 
			var newVisitLabel = date + " " + startHour + ":" + startMinutes + 
			" to " + endHour + ":" + endMinutes; 
			
			var index = $("#addedVisits input").length;
			
			var label = "<p>" + newVisitLabel + "</p>";
			var input = "<input type='hidden' value='" + newVisit + "' name='visits[" + index + "]' />";
			
			$("#addedVisits").append(label + input);
		});

	});
</script>

<!--
<pre><a href="/">Home</a>   &gt;   Place ad</pre>
-->

<h1>Place an ad</h1>
<hr />



<form:form method="post" modelAttribute="placeAdForm"
	action="/profile/placeAd" id="placeAdForm" autocomplete="off"
	enctype="multipart/form-data" style="width:100%">
	<table style="width:100%;height:100%;table-layout: fixed;">
	<tr>
	
	
	<td style="width:50%;height:320px;">
	
	<fieldset style="height:100%;" >
		<legend>General description</legend>
		<table class="placeAdTable">
			
			
			<tr>
			<td style="background-color:#fff9f9"><label for="field-type">Type of deal:</label>
				
				<!-- uses the scripts above to put the values of the radio buttons in these two invisible fields
				these two invisible fields are then written into the form
				-->
				<form:input type="hidden" id="ActualSale" path="sale"  value="direct" readonly="readonly" />
				<form:input type="hidden" id="ActualDeal" path="deal"  value="forRent" readonly="readonly" />
				
				<input id="type-rent" type="radio" name="sale" value="forRent" checked="checked"> Rent
				<input id="type-sale"  type="radio" name="sale" value="forSale"> Sale
				<input id="type-auction" type="radio" name="sale" value="forAuction"> Auction
				
				
				
				
				</td>

			</tr>	

			<tr>
				<td style="background-color:#fff9f9"><label for="field-title">Title of your ad :</label> 
				<form:input id="field-title" path="title" placeholder="ad title" /></td>
			</tr>
			
			<tr>
			<td style="background-color:#fff9f9"><label for="field-street">Address :</label>
				<form:input id="field-street" path="street" placeholder="street" /></td>
			</tr>
			
			<tr>
			<td style="background-color:#fff9f9"><label for="field-city">City :</label>
				<form:input id="field-city" path="city" placeholder="city" />
				<form:errors path="city" cssClass="validationErrorText" /></td>
			</tr>

			<tr>
				<td style="background-color:#fff9f9"><label for="field-squareFootage">Square Meters (m²) :</label>
					<form:input id="field-squareFootage" type="number" path="squareFootage" placeholder="number of square meters"  min="0" />
					<form:errors path="squareFootage" cssClass="validationErrorText" /></td>
			</tr>
			
			<tr>
				<td style="background-color:#fff9f9"><label for="field-numberRooms">Number of Rooms :</label>
					<form:input id="field-numberRooms" type="number" path="numberOfRooms" placeholder="Number of Rooms" min="0" />
					<form:errors path="numberOfRooms" cssClass="validationErrorText" /></td>
			</tr>
			
			<tr>
				<td style="background-color:#fff9f9"><label for="moveInDate">Move-in date :</label>
				<form:input type="text" id="field-moveInDate" path="moveInDate" /></td>
			</tr>
			
			<tr>
				<td><label for="moveOutDate">Move-out date (optional) :</label>
				<form:input type="text" id="field-moveOutDate" path="moveOutDate" /></td>
			</tr>



		</table>
	</fieldset>
	
	</td>
	
	<td style="width:50%;height:320px;">
	<fieldset style="height:100%;" >
		<legend>Deal</legend>
		
		<table class="placeAdTable">
			
			<tr>
				<td style="background-color:#fff9f9"><label id="rentLabel" for="field-priceRent">Monthly rental charges (CHF) :</label>
				<form:input id="field-priceRent" type="number" path="prize"  min="0"/>
				<form:errors path="prize" cssClass="validationErrorText" /></td>
			</tr>
		
			<tr>
				<td style="background-color:#fff9f9"><label id="saleLabel" for="field-priceSale">Price for a direct sale (CHF) :</label>
				<form:input id="field-priceSale" type="number" path="prize" min="0" />
				<form:errors path="prize" cssClass="validationErrorText" /></td>
			</tr>
			
			<tr>
				<td style="background-color:#fff9f9"><label id="bidLabel" for="field-currentBid">Initial bid for a sale through auction (CHF) :</label>
				<form:input id="field-currentBid" type="number" path="currentBid" min="0"/>
				<form:errors path="currentBid" cssClass="validationErrorText" /></td>
			</tr>
			
			<tr>				
				<td style="background-color:#fff9f9"><label id="incLabel" for="field-increment">Automatic increment for each new bid (CHF) :</label>
				<form:input id="field-increment" type="number" path="increment" min="0"/>
				<form:errors path="increment" cssClass="validationErrorText" /></td>			
			</tr>
			
			<tr>
				<td style="background-color:#fff9f9"><label id="deadLabel" for="field-deadlineDate">Deadline</label>
					<input id="field-deadlineDate" />
					
					<select id="field-deadlineHour">
						<%
							for (int i = 0; i < 24; i++) {
									String hour = String.format("%02d", i);
									out.print("<option value=\"" + hour + "\">" + hour + "</option>");
								}
						%>
					</select> 
						
					<select id="field-deadlineMinute">
						<%
							for (int i = 0; i < 60; i++) {
									String minute = String.format("%02d", i);
									out.print("<option value=\"" + minute + "\">" + minute + "</option>");
								}
						%>
					</select>
				</td>
			</tr>
			
		</table>
	</fieldset>
	</td>
	
	</tr>
	
	<tr>
	
	<td style="width:100%;height:400px;">
	<fieldset style="height:100%;" >
		<legend>Room content</legend>
		<table class="placeAdTable">
		
			<tr>
				<td><form:checkbox id="field-animals" path="animals" value="1" /><label>Smoking inside allowed</label></td>
				<td><form:checkbox id="field-internet" path="internet" value="1" /><label>WiFi available</label></td>
				
			</tr>
			
			<tr>
				<td><form:checkbox id="field-smoker" path="smokers" value="1" /><label>Animals allowed</label></td>
				<td><form:checkbox id="field-cable" path="cable" value="1" /><label>TV Cable</label></td>
				
			</tr>
			
			<tr>
				<td><form:checkbox id="field-furnished" path="furnished" value="1" /><label>Furnished</label></td>
				<td><form:checkbox id="field-garage" path="garage" value="1" /><label>Garage</label></td>
						
			</tr>
			
			<tr>
				<td><form:checkbox id="field-cellar" path="cellar" value="1" /><label>Cellar/Attic</label></td>
				<td><form:checkbox id="field-garden" path="garden" value="1" /><label>Garden (co-use)</label></td>
			</tr>
			
			<tr>
				<td><form:checkbox id="field-balcony" path="balcony" value="1" /><label>Balcony/Patio</label></td>	
			</tr>

			
			<tr>
				<td colspan="2" >
					<form:textarea style="background-color:#fff9f9;color:black;" path="roomDescription" rows="10" cols="80" placeholder="room Description" />
					<form:errors path="roomDescription" cssClass="validationErrorText" />
				</td>
			</tr>
		</table>
	</fieldset>
	</td>
	
	
	
	<td style="width:50%;height:400px;">
	<fieldset style="height:100%;" >
		<legend>Location details (optional)</legend>
		<table class="placeAdTable">
			<tr>
				<td><label for="field-ProximityToPublicTransport">Proximity to Public Transport in meters</label>
				<form:input id="field-ProximityToPublicTransport" type="number" path="proximityToPublicTransport" placeholder="e.g. 500" /></td>
			</tr>
			<tr>
				<td><label for="field-ProximityToSchool">Proximity to School in meters</label>
				<form:input id="field-ProximityToSchool" type="number" path="proximityToSchool" placeholder="e.g. 500"  /></td>
			</tr>
			<tr>
				<td><label for="field-ProximityToSupermarket">Proximity to Supermarket in meters</label>
				<form:input id="field-ProximityToSupermarket" type="number" path="proximityToSupermarket" placeholder="e.g. 500"   /></td>
			</tr>
			<tr>
				<td><label for="field-ProximityToNightlife">Proximity to Night Life in meters</label>
				<form:input id="field-ProximityToNightlife" type="number" path="proximityToNightlife" placeholder="e.g. 500"   /></td>
			</tr>
		</table>
	</fieldset>
	</td>
	
	</tr>
	
	<tr>
	
	<td style="width:50%;height:210px;">
	
	<fieldset id="preference" style="height:100%;">
		<legend>Preferences (optional)</legend>
		<form:textarea path="preferences" rows="5" cols="80" placeholder="preferences concerning the tenant"></form:textarea>
	</fieldset>
	
	</td>
	
	<td style="width:50%;height:210px;">
	
	<fieldset style="height:100%;">
		<legend>Pictures (optional)</legend>
		<br /> 
		<label for="field-pictures">Pictures</label> <input type="file" id="field-pictures" accept="image/*" multiple="multiple" />
		<table id="uploaded-pictures" class="styledTable">
			<tr>
				<th id="name-column">Uploaded picture</th>
				<th>Size</th>
				<th>Delete</th>
			</tr>
		</table>
		<br>
	</fieldset>

	</td>
	
	<td>
	
	<fieldset style="height:100%;">
		<legend>Visits timetable (optional)</legend>
		<table>
			<tr>
				<td><input type="text" id="field-visitDay" readonly="readonly" /> <select
					id="startHour">
						<%
							for (int i = 0; i < 24; i++) {
									String hour = String.format("%02d", i);
									out.print("<option value=\"" + hour + "\">" + hour
											+ "</option>");
								}
						%>
				</select> <select id="startMinutes">
						<%
							for (int i = 0; i < 60; i++) {
									String minute = String.format("%02d", i);
									out.print("<option value=\"" + minute + "\">" + minute
											+ "</option>");
								}
						%>
				</select> <span>to&thinsp; </span> <select id="endHour">
						<%
							for (int i = 0; i < 24; i++) {
									String hour = String.format("%02d", i);
									out.print("<option value=\"" + hour + "\">" + hour
											+ "</option>");
								}
						%>
				</select> <select id="endMinutes">
						<%
							for (int i = 0; i < 60; i++) {
									String minute = String.format("%02d", i);
									out.print("<option value=\"" + minute + "\">" + minute
											+ "</option>");
								}
						%>
				</select>



					<div id="addVisitButton" class="smallPlusButton">+</div>

					<div id="addedVisits"></div></td>

			</tr>
		</table>
		<br>
	</fieldset>
	
	
	</td>
	
	</tr>
	
	</table>

	<br />
	
	<div>
		<a href="/"><button type="button">Cancel</button></a>
		<button type="submit">Submit</button>
	</div>


</form:form>

<c:import url="template/footer.jsp" />
