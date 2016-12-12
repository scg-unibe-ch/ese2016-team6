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

    	$("#type-rent").on("click", function(){
    		
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
			
			document.getElementById('forRent').checked = true;
			document.getElementById('forSale').checked = false;
			document.getElementById('forAuction').checked = false;
			
			document.getElementById('preference').style.visibility = "visible";
			document.getElementById('preferences').style.visibility = "visible";
			
			$("#field-priceRent").parent().show();
			$("#field-priceSale").parent().hide();
			$("#field-currentBid").parent().hide();
			$("#field-increment").parent().hide();
			$("#field-deadlineDate").parent().hide();
			$("#field-deadlineHour").parent().hide();
			$("#field-deadlineMinute").parent().hide();
			$("#preferences").parent().show();
			$("#preference").parent().show();
    	});

		$("#type-sale").on("click", function(){
			document.getElementById('field-priceRent').style.visibility = "hidden";
        	document.getElementById('field-priceSale').style.visibility = "visible";
        	document.getElementById('field-currentBid').style.visibility = "hidden";
        	document.getElementById('field-increment').style.visibility = "hidden";
			document.getElementById('field-deadlineDate').style.visibility = "hidden";
			document.getElementById('field-deadlineHour').style.visibility = "hidden";
			document.getElementById('field-deadlineMinute').style.visibility = "hidden";
			document.getElementById('preferences').style.visibility = "hidden";
			document.getElementById('preference').style.visibility = "hidden";
			
			document.getElementById('rentLabel').style.visibility = "hidden";
			document.getElementById('saleLabel').style.visibility = "visible";
			document.getElementById('bidLabel').style.visibility = "hidden";
			document.getElementById('incLabel').style.visibility = "hidden";
			document.getElementById('deadLabel').style.visibility = "hidden";
			
			document.getElementById('forRent').checked = false;
			document.getElementById('forSale').checked = true;
			document.getElementById('forAuction').checked = false;
			
			$("#field-priceSale").parent().show();
			$("#field-priceRent").parent().hide();
			$("#field-currentBid").parent().hide();
			$("#field-increment").parent().hide();
			$("#field-deadlineDate").parent().hide();
			$("#field-deadlineHour").parent().hide();
			$("#field-deadlineMinute").parent().hide();
			$("#preferences").parent().hide();
			$("#preference").parent().hide();

   		});

    	$("#type-auction").on("click", function(){	
			document.getElementById('field-priceRent').style.visibility = "hidden";
        	document.getElementById('field-priceSale').style.visibility = "visible";
        	document.getElementById('field-currentBid').style.visibility = "visible";
        	document.getElementById('field-increment').style.visibility = "visible";
			document.getElementById('field-deadlineDate').style.visibility = "visible";
			document.getElementById('field-deadlineHour').style.visibility = "visible";
			document.getElementById('field-deadlineMinute').style.visibility = "visible";
			document.getElementById('preferences').style.visibility = "hidden";
			document.getElementById('preference').style.visibility = "hidden";
			
			
			document.getElementById('rentLabel').style.visibility = "hidden";
			document.getElementById('saleLabel').style.visibility = "visible";
			document.getElementById('bidLabel').style.visibility = "visible";
			document.getElementById('incLabel').style.visibility = "visible";
			document.getElementById('deadLabel').style.visibility = "visible";
			
			document.getElementById('forRent').checked = true;
			document.getElementById('forSale').checked = false;
			document.getElementById('forAuction').checked = false;
			
			$("#field-priceRent").parent().hide();
			$("#field-priceSale").parent().show();
			$("#field-currentBid").parent().show();
			$("#field-increment").parent().show();
			$("#field-deadlineDate").parent().show();
			$("#field-deadlineHour").parent().show();
			$("#field-deadlineMinute").parent().show();
			$("#preferences").parent().hide();
			$("#preference").parent().hide();
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
		
		if (document.getElementById('forAuction').checked) {
			$("#type-auction").prop('checked', true);
			$("#type-auction").click();
		} else if(document.getElementById('forSale').checked){
			$("#type-sale").prop('checked', true);
			$("#type-sale").click();
		} else {
			$("#type-rent").prop('checked', true);
			$("#type-rent").click();
		}
	});
</script>

<!--
<pre><a href="/">Home</a>   &gt;   Place ad</pre>
-->

<h1 style="margin:0px;text-align:center">Place an ad </h1>
<p style="margin:0px;text-align:center"> Every Field with a * needs to be filled out </p>
<hr style="margin:0px" />



<form:form method="post" modelAttribute="placeAdForm"
	action="/profile/placeAd" id="placeAdForm" autocomplete="off"
	enctype="multipart/form-data" style="width:100%">
	
	<table class="placeAdTableOne">
	<tr>
	
	
	<td >
	
	<fieldset class="placeAdFieldsetOne">
		<legend>General description</legend>
		<div>
		
		<table class="placeAdTable">
			
			
			<tr>
			<td style="background-color:#fff9f9"><label for="field-type">Type of deal*:</label>

				<!-- uses the scripts above to put the values of the radio buttons in these two invisible fields
				these two invisible fields are then written into the form -->
				
				<form:checkbox style="display:none" id="forSale" path="forSale" value="forSale"/>
				<form:checkbox style="display:none" id="forRent" path="forRent" value="forRent"/>
				<form:checkbox style="display:none" id="forAuction" path="forAuction" value="forAuction"/>				
				
				<input id="type-rent" type="radio" name="sale" value="forRent"> For Rent
				<input id="type-sale"  type="radio" name="sale" value="forSale"> For Sale
				<input id="type-auction" type="radio" name="sale" value="forAuction"> For Auction
				</td>
			</tr>	
			<tr>
				<td style="background-color:#fff9f9"><label for="field-title">Title of your ad *:</label> 
				<form:input id="field-title" path="title" placeholder="ad title" />
				<form:errors path="title" cssClass="validationErrorText" /></td>
			</tr>
			
			<tr>
			<td style="background-color:#fff9f9"><label for="field-street">Address *:</label>
				<form:input id="field-street" path="street" placeholder="street" /></td>
				<form:errors path="street" cssClass="validationErrorText" />
			</tr>
			
			<tr>
			<td style="background-color:#fff9f9"><label for="field-city">City *:</label>
				<form:input id="field-city" path="city" placeholder="city" />
				<form:errors path="city" cssClass="validationErrorText" /></td>
			</tr>

			<tr>
				<td style="background-color:#fff9f9"><label for="field-squareFootage">Square Meters (m²) *:</label>
					<form:input id="field-squareFootage" type="number" max="100000" path="squareFootage" placeholder="number of square meters"  min="1" value="1" />
					<form:errors path="squareFootage" cssClass="validationErrorText" /></td>
			</tr>
			
			<tr>
				<td style="background-color:#fff9f9"><label for="field-numberRooms">Number of Rooms *:</label>
					<form:input id="field-numberRooms" type="number" max="1000" path="numberOfRooms" placeholder="Number of Rooms" min="1" value="1" />
					<form:errors path="numberOfRooms" cssClass="validationErrorText" /></td>
			</tr>
			
			<tr>
				<td style="background-color:#fff9f9"><label for="moveInDate">Move-in date *:</label>
				<form:input type="text" id="field-moveInDate" path="moveInDate" />
				<form:errors path="moveInDate" cssClass="validationErrorText" /></td>
			</tr>
			
			<tr>
				<td><label for="moveOutDate">Move-out date :</label>
				<form:input type="text" id="field-moveOutDate" path="moveOutDate" /></td>
			</tr>
		</table>
		
		</div>
	</fieldset>
	
	</td>
	
	<td >
	<fieldset class="placeAdFieldsetOne">
		<legend>Deal</legend>
		<div>
		<table class="placeAdTable">
			
			<tr>
				<td style="background-color:#fff9f9"><label id="rentLabel" for="field-priceRent">Monthly rental charges (CHF) *:</label>
				<form:input id="field-priceRent" type="number" path="priceRent"  min="1" value="1"/>
				<form:errors path="priceRent" cssClass="validationErrorText" /></td>
			</tr>
		
			<tr>
				<td style="background-color:#fff9f9"><label id="saleLabel" for="field-priceSale">Price for a direct sale (CHF) *:</label>
				<form:input id="field-priceSale" type="number" path="priceSale" min="1" value="1"/>
				<form:errors path="priceSale" cssClass="validationErrorText" /></td>
			</tr>
			
			<tr>
				<td style="background-color:#fff9f9"><label id="bidLabel" for="field-currentBid">Initial bid for a sale through auction (CHF) *:</label>
				<form:input id="field-currentBid" type="number" path="currentBid" min="1" value="1"/>
				<form:errors path="currentBid" cssClass="validationErrorText" /></td>
			</tr>
			
			<tr>				
				<td style="background-color:#fff9f9"><label id="incLabel" for="field-increment">Automatic increment for each new bid (CHF) *:</label>
				<form:input id="field-increment" type="number" path="increment" min="1" value="1"/>
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
		</div>
	</fieldset>
	</td>
	
	</tr>
	
	<tr>
	
	<td >
	<fieldset class="placeAdFieldsetOne" >
		<legend>Flat content</legend>
		
		<div>
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
					<form:textarea style="background-color:#fff9f9;color:black;" path="roomDescription" rows="10" cols="70" placeholder="Room Description*" />
					<form:errors path="roomDescription" cssClass="validationErrorText" />
				</td>
			</tr>
		</table>
		<br/>
		</div>
	</fieldset>
	</td>
	
	
	
	<td >
	<fieldset class="placeAdFieldsetOne">
	
		<legend>Location details (optional)</legend>
		<div>
		<table class="placeAdTable">
			<tr>
				<td><label for="field-ProximityToPublicTransport">Proximity to Public Transport in meters</label>
				<form:input id="field-ProximityToPublicTransport" type="number" max="10000" path="proximityToPublicTransport" placeholder="e.g. 500" />
				</td>
			</tr>
			<tr>
				<td><label for="field-ProximityToSchool">Proximity to School in meters</label>
				<form:input id="field-ProximityToSchool" type="number" max="10000" path="proximityToSchool" placeholder="e.g. 500"  />
				</td>
			</tr>
			<tr>
				<td><label for="field-ProximityToSupermarket">Proximity to Supermarket in meters</label>
				<form:input id="field-ProximityToSupermarket" type="number" max="10000" path="proximityToSupermarket" placeholder="e.g. 500"   />
				</td>
			</tr>
			<tr>
				<td><label for="field-ProximityToNightlife">Proximity to Night Life in meters</label>
				<form:input id="field-ProximityToNightlife" type="number" max="10000" path="proximityToNightlife" placeholder="e.g. 500"   />
				</td>
			</tr>
		</table>
		</div>
	</fieldset>
	</td>
	
	</tr>
	
	<tr>
	
	<td >
	
	<fieldset class="placeAdFieldsetOne">
		<legend>Pictures (optional)</legend>
		<div>
		<br /> 
		<label for="field-pictures">Pictures</label> <input type="file" id="field-pictures" accept="image/*" multiple="multiple" />
		<table id="uploaded-pictures" class="styledTable">
			<tr>
				<th id="name-column">Uploaded Picture</th>
				<th>Size</th>
				<th>Delete</th>
			</tr>
		</table>
		<br>
		</div>
	</fieldset>
	
		</td>
		<td>
	
		<fieldset class="placeAdFieldsetOne" >
		<legend>Visits timetable (optional)</legend>
		<div>
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
		</div>
	</fieldset>

	</td>
	
	<tr>
	

	
	<td >
	
	<fieldset id="preference" class="placeAdFieldsetOne">
		<legend>Preferences (optional)</legend>
		<div>
		<form:textarea path="preferences" rows="5" cols="70" placeholder="preferences concerning the tenant"></form:textarea>
		</div>
	</fieldset>	
	</td>
	
	
	<td>
		<div>
			<a  href="/"><button style="background-color:#991f00;color:white" type="button">Cancel</button></a>
			<button style="background-color:#ffffcc" type="submit">Submit</button>
		</div>
	
	</td>
	
	</tr>
	
	</table>

	<br />
	
	


</form:form>

<c:import url="template/footer.jsp" />
