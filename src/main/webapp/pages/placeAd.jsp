<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
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
			dateFormat : 'dd-mm-yy'
		});
		
		$("#field-moveOutDate").datepicker({
			dateFormat : 'dd-mm-yy'
		});
		
		$("#field-visitDay").datepicker({
			dateFormat : 'dd-mm-yy'
		});
		
		$("#field-deadlineDay").datepicker({
			dateFormat : 'dd-mm-yy'
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

<pre><a href="/">Home</a>   &gt;   Place ad</pre>

<h1>Place an ad</h1>

<hr />

<form:form method="post" modelAttribute="placeAdForm"
	action="/profile/placeAd" id="placeAdForm" autocomplete="off"
	enctype="multipart/form-data">

	<fieldset>
		<legend>General description</legend>
		<table class="placeAdTable">
			
			<tr>
			<td><label for="field-title">Title of your ad :</label> 
				<form:input id="field-title" path="title" placeholder="ad title" /></td>
			</tr>
			
			<tr>
			<td><label for="forRent">Status :</label>
				<form:radiobutton id="for-sale" path="rent" value="0" checked="checked"/> For Rent 
				<form:radiobutton id="for-rent" path="rent" value="1"/> For Sale </td>
			</tr>
			
			<tr>
			<td><label for="field-street">Address :</label>
				<form:input id="field-street" path="street" placeholder="street" /></td>
				
			<td><label for="field-city">City :</label>
				<form:input id="field-city" path="city" placeholder="city" />
				<form:errors path="city" cssClass="validationErrorText" /></td>
			</tr>

			<tr>
				<td><label for="field-SquareFootage">Square Meters :</label>
					<form:input id="field-SquareFootage" type="number" path="squareFootage" placeholder="number of square meters" step="2" />
					<form:errors path="squareFootage" cssClass="validationErrorText" /></td>
					
				<td><label for="field-NumberRooms">Number of Rooms :</label>
					<form:input id="field-NumberRooms" type="number" path="numberOfRooms" placeholder="Number of Rooms" step="1" />
					<form:errors path="numberOfRooms" cssClass="validationErrorText" /></td>
			</tr>
			
			<tr>
				<td><label for="moveInDate">Move-in date :</label>
				<form:input type="text" id="field-moveInDate" path="moveInDate" /></td>
				
				<td><label for="moveOutDate">Move-out date (optional) :</label>
				<form:input type="text" id="field-moveOutDate" path="moveOutDate" /></td>
			</tr>

		</table>
	</fieldset>
	
	<fieldset>
		<legend>Type of deal</legend>
		<table class="placeAnAd">
			
			<!--the error message should work only if no field is filled out-->
			
			<tr>
				<td>If for Rent :<td>
			</tr>
			
			<tr>
				<td><label for="field-Prize">Monthly rental charges :</label>
				<form:input id="for-rent" type="number" path="rent" step="50"/></br></br></td>
			</tr>
			
			<tr>
				<td>If for Sale :</td>
			</tr>
			
			<tr>
				<td><i>You can choose either "Direct sale", or "Sale through auction" or both</i><td>
			</tr>
			
			<tr>
				<td><label for="field-Prize">Price for a direct sale</label>
				<form:input id="for-sale" type="number" path="rent" step="50" /></td>
			</tr>
			
			<tr>
				<td><label for="field-Prize">Initial bid for a sale through auction</label>
				<form:input id="for-sale" type="number" path="rent" step="50"/></td>
				
				<td><label for="field-Prize">Automatic increment for each new bid</label>
				<form:input id="for-sale" type="number" path="rent" step="2" /></td>			
			</tr>
			
			<tr>
				<td><label for="field-Prize">Deadline</label>
					<input type="text" id="field-deadlineDay" />
					<select id="startHour">
						<%
							for (int i = 0; i < 24; i++) {
									String hour = String.format("%02d", i);
									out.print("<option value=\"" + hour + "\">" + hour + "</option>");
								}
						%>
					</select> 
						
					<select id="startMinutes">
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

	<fieldset>
		<legend>Room content</legend>
		<table class="placeAdTable">
		
			<tr>
				<td><form:checkbox id="field-animals" path="animals" value="1" /><label>Smoking inside allowed</label></td>
				<td><form:checkbox id="field-internet" path="internet" value="1" /><label>WiFi available</label></td>
				<td><form:checkbox id="field-cellar" path="cellar" value="1" /><label>Cellar/Attic</label></td>
			</tr>
			
			<tr>
				<td><form:checkbox id="field-smoker" path="smokers" value="1" /><label>Animals allowed</label></td>
				<td><form:checkbox id="field-cable" path="cable" value="1" /><label>TV Cable</label></td>
				<td><form:checkbox id="field-garden" path="garden" value="1" /><label>Garden (co-use)</label></td
			</tr>
			
			<tr>
				<td><form:checkbox id="field-furnished" path="furnished" value="1" /><label>Furnished</label></td>
				<td><form:checkbox id="field-garage" path="garage" value="1" /><label>Garage</label></td>
				<td><form:checkbox id="field-balcony" path="balcony" value="1" /><label>Balcony/Patio</label></td>			
			</tr>

		</table>

		<br/>
	
		<form:textarea path="roomDescription" rows="10" cols="100" placeholder="room Description" />
		<form:errors path="roomDescription" cssClass="validationErrorText" />
		
	</fieldset>
	
	<fieldset>
		<legend>Preferences (optional)</legend>
		<form:textarea path="preferences" rows="5" cols="100" placeholder="preferences concerning the tenant"></form:textarea>
	</fieldset>

	<%--
	
	removed because of customer wishes
	
	<fieldset>
		<legend>Roommates (optional)</legend>
		<p>If your roommates have an account, simply add them by email.</p>

		<table class="placeAdTable">
			<tr>
				<td><label for="roomFriends">Add by email</label></td>
			</tr>

			<tr>
				<td id="roommateCell"><form:input type="text" id="roomFriends"
						path="roomFriends" placeholder="email" />

					<div id="addbutton" class="smallPlusButton">+</div></td>
			</tr>
			<tr>
				<td><p id="addedRoommates" path="addedRoommates">Added
						roommates:</p></td>
			</tr>
		</table>

		<br />
		<p>If the roommates do not have accounts or you wish to give
			further information, you can add a text in which you describe the
			roommates.</p>
		<br/>
		<form:textarea path="roommates" rows="10" cols="100"
			placeholder="Roommates" />
		<form:errors path="roommates" cssClass="validationErrorText" />
	</fieldset>

	--%>

	<fieldset>
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

	<fieldset>
		<legend>Visits timetable (optional)</legend>
		<table>
			<tr>
				<td><input type="text" id="field-visitDay" /> <select
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

	<br />
	
	<div>
		<button type="submit">Submit</button>
		<a href="/"><button type="button">Cancel</button></a>
	</div>

</form:form>

<c:import url="template/footer.jsp" />
