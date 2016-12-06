<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="template/header.jsp" />

<script src="/js/jquery.ui.widget.js"></script>
<script src="/js/jquery.iframe-transport.js"></script>
<script src="/js/jquery.fileupload.js"></script>
<script src="/js/pictureUploadEditAd.js"></script>
<script src="/js/editAd.js"></script>


<script>
	$(document).ready(function() {	

		setTimeout(function() {
			if ($("#ActualDeal").val() == "forRent") {
				$("#type-rent").trigger('click');
			} else {
				if ($("#ActualSale").val() == "direct") {
					$("#type-sale").trigger('click');
				}
				if ($("#ActualSale").val() == "bothAuctionAndDirect") {
					$("#type-auction").trigger('click');
				}
			}
		},10);

		

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
			
			document.getElementById('preferences').style.visibility = "visible";
			document.getElementById('preference').style.visibility = "visible";
			
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
			document.getElementById('type-rent').checked="";
			document.getElementById('type-auction').checked="";
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
			
			document.getElementById('ActualSale').value = "direct";
			document.getElementById('ActualDeal').value = "forSale";
			
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
    		document.getElementById('type-rent').checked="";
			document.getElementById('type-sale').checked="";
			
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
			
			document.getElementById('ActualSale').value = "bothAuctionAndDirect";
			document.getElementById('ActualDeal').value = "forSale";
			
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
		
		
		$("#addbutton").click(function() {
			var text = $("#roomFriends").val();
			var alreadyAdded = $("#addedRoommates").html();
			if(validateForm(text)) {
				$.post("/profile/placeAd/validateEmail",{email: text, alreadyIn: alreadyAdded}, function(data) {
					if(validateForm(data)) {
						// length gibt die Anzahl der Elemente im input.roommateInput an. Dieser wird in index geschrieben und iteriert.
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
		
		$(".deleteRoommateButton").click(function()  {
			var userId = $(this).attr("data-user-id");
			var adId = $(this).attr("data-ad-id");
			var row = $(this).parent().parent();
			$.post("/profile/editAd/deleteRoommate", {userId: userId, adId: adId}, function() {
				$(row).animate({opacity: 0}, 300, function() {$(row).remove(); } );
			});
		
		});
	});
</script>

<!-- format the dates -->
<fmt:formatDate value="${ad.moveInDate}" var="formattedMoveInDate"
	type="date" pattern="dd-MM-yyyy" />
<fmt:formatDate value="${ad.moveOutDate}" var="formattedMoveOutDate"
	type="date" pattern="dd-MM-yyyy" />

<h1>Edit Ad</h1>
<hr style="margin:0px;" />


<!-- first row -->

<table class="editTableOne">

<form:form method="post" modelAttribute="placeAdForm"
	action="/profile/editAd" id="placeAdForm" autocomplete="off"
	enctype="multipart/form-data">

<input type="hidden" name="adId" value="${ad.id }" />


	<tr>
	<td>
	<fieldset class="editFieldsetOne" >
		
		<legend>Change General description</legend>
		<div>
			<table class="placeAdTable">

				<tr>
					<td><label for="field-type">Type of deal:</label>
						
						<form:input type="hidden" id="ActualDeal" path="deal"  value="${ad.deal}" readonly="readonly" />	
						<form:input type="hidden" id="ActualSale" path="sale"  value="${ad.sale}" readonly="readonly" />
						
						<c:choose>
							<c:when test="${ad.deal eq 'forRent'}">
								<input id="type-rent" type="radio" name="sale" value="forRent" checked="checked" />Rent
							</c:when>
							<c:otherwise>
								<input id="type-rent" type="radio" name="sale" value="forRent" />Rent
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${ad.deal eq 'forSale' && ad.sale eq 'direct'}">
								<input id="type-sale" type="radio" name="sale" value="forSale" checked="checked" />Sale
							</c:when>
							<c:otherwise>
								<input id="type-sale" type="radio" name="sale" value="forSale" />Sale
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${ad.sale eq 'bothAuctionAndDirect' && ad.deal eq 'forSale'}">
								<input id="type-auction" type="radio" name="sale" value="forAuction" checked="checked" />Auction
							</c:when>
							<c:otherwise>
								<input id="type-auction" type="radio" name="sale" value="forAuction" />Auction
							</c:otherwise>
						</c:choose>
					</td>

				</tr>

				<tr>
					<td><label for="field-title">Title of your ad :</label> 
					<form:input id="field-title" path="title" value="${ad.title}" /></td>
				</tr>

				<tr>
				<td><label for="field-street">Address :</label>
					<form:input id="field-street" path="street" value="${ad.street}" /></td>
				</tr>
				
				<tr>
				<td><label for="field-city">City :</label>
					<form:input id="field-city" path="city" value="${ad.zipcode} - ${ad.city}" />
					<form:errors path="city" cssClass="validationErrorText" /></td>
				</tr>

				<tr>
					<td><label for="field-squareFootage">Square Meters (m²) :</label>
						<form:input id="field-squareFootage" type="number" path="squareFootage" value="${ad.squareFootage}" min="0" />
						<form:errors path="squareFootage" cssClass="validationErrorText" /></td>
				</tr>
				
				<tr>
					<td><label for="field-numberRooms">Number of Rooms :</label>
						<form:input id="field-numberRooms" type="number" path="numberOfRooms" value="${ad.numberOfRooms}" min="0" />
						<form:errors path="numberOfRooms" cssClass="validationErrorText" /></td>
				</tr>
				
				<tr>
					<td><label for="moveInDate">Move-in date :</label>
					<form:input type="text" id="field-moveInDate" path="moveInDate" value="${formattedMoveInDate}" /></td>
				</tr>
				
				<tr>
					<td><label for="moveOutDate">Move-out date (optional) :</label>
					<form:input type="text" id="field-moveOutDate" path="moveOutDate" value="${formattedMoveOutDate}" /></td>
				</tr>
				
			</table>
		</div>
	</fieldset>

	</td>
	
	<td>
	
	<fieldset class="editFieldsetOne" >
		<legend>Deal</legend>
		
		<div>
			<table class="placeAdTable">

				<tr>
					<td><label id="rentLabel" for="field-priceRent">Monthly rental charges (CHF) :</label>
					<form:input id="field-priceRent" type="number" path="priceRent" value="${ad.priceRent}" min="0"/>
					<form:errors path="priceRent" cssClass="validationErrorText" /></td>
				</tr>
			
				<tr>
					<td><label id="saleLabel" for="field-priceSale">Price for a direct sale (CHF) :</label>
					<form:input id="field-priceSale" type="number" path="priceSale" value="${ad.priceSale}" min="0" />
					<form:errors path="priceSale" cssClass="validationErrorText" /></td>
				</tr>
				
				<tr>
					<td><label id="bidLabel" for="field-currentBid">Initial bid for a sale through auction (CHF) :</label>
					<form:input id="field-currentBid" type="number" path="currentBid" value="${ad.currentBid}" min="0"/>
					<form:errors path="currentBid" cssClass="validationErrorText" /></td>
				</tr>
				
				<tr>				
					<td><label id="incLabel" for="field-increment">Automatic increment for each new bid (CHF) :</label>
					<form:input id="field-increment" type="number" path="increment" value="${ad.increment}" min="0"/>
					<form:errors path="increment" cssClass="validationErrorText" /></td>			
				</tr>
				
				<!-- add to formatDate and add proper values -->
				<tr>
					<td><label id="deadLabel" for="field-deadlineDate">Deadline</label>
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
	
	<td>
	
	<fieldset class="editFieldsetOne" >
		<legend>Change Location details</legend>
		
		<div>
			<table class="placeAdTable">
				<tr>
					<td><label for="field-ProximityToPublicTransport">Proximity to Public Transport in meters</label>
					<form:input id="field-ProximityToPublicTransport" type="number" path="proximityToPublicTransport" value="${ad.proximityToPublicTransport}" /></td>
				</tr>
				<tr>
					<td><label for="field-ProximityToSchool">Proximity to School in meters</label>
					<form:input id="field-ProximityToSchool" type="number" path="proximityToSchool" value="${ad.proximityToSchool}" /></td>
				</tr>
				<tr>
					<td><label for="field-ProximityToSupermarket">Proximity to Supermarket in meters</label>
					<form:input id="field-ProximityToSupermarket" type="number" path="proximityToSupermarket" value="${ad.proximityToSupermarket}" /></td>
				</tr>
				<tr>
					<td><label for="field-ProximityToNightlife">Proximity to Night Life in meters</label>
					<form:input id="field-ProximityToNightlife" type="number" path="proximityToNightlife" value="${ad.proximityToNightlife}" /></td>
				</tr>
			</table>
		</div>
	</fieldset>
	
	</td>
	</tr>
	</table>
	
	
	<!-- second row -->
	
	<table class="editTableTwo">
	
	<tr>
	<td>
	
	<fieldset class="editFieldsetTwo">
		<legend>Room content</legend>
		<div>
		<table class="placeAdTable">
			<tr>
				<td>
					<c:choose>
						<c:when test="${ad.smokers}">
							<form:checkbox id="field-smoker" path="smokers" checked="checked" /><label>Smoking
							inside allowed</label>
						</c:when>
						<c:otherwise>
							<form:checkbox id="field-smoker" path="smokers" /><label>Smoking
							inside allowed</label>
						</c:otherwise>
					</c:choose>
				</td>
				
				<td>
					<c:choose>
						<c:when test="${ad.animals}">
							<form:checkbox id="field-animals" path="animals"  checked="checked" /><label>Animals
						allowed</label>
						</c:when>
						<c:otherwise>
							<form:checkbox id="field-animals" path="animals" /><label>Animals
						allowed</label>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td>
					<c:choose>
						<c:when test="${ad.garden}">
							<form:checkbox id="field-garden" path="garden" checked="checked" /><label>Garden
							(co-use)</label>
						</c:when>
						<c:otherwise>
							<form:checkbox id="field-garden" path="garden" /><label>Garden
							(co-use)</label>
						</c:otherwise>
					</c:choose>
				</td>
				
				<td>
					<c:choose>
						<c:when test="${ad.balcony}">
							<form:checkbox id="field-balcony" path="balcony"  checked="checked" /><label>Balcony
						or Patio</label>
						</c:when>
						<c:otherwise>
							<form:checkbox id="field-balcony" path="balcony" /><label>Balcony
						or Patio</label>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td>
					<c:choose>
						<c:when test="${ad.cellar}">
							<form:checkbox id="field-cellar" path="cellar" checked="checked" /><label>Cellar
						or Attic</label>
						</c:when>
						<c:otherwise>
							<form:checkbox id="field-cellar" path="cellar" /><label>Cellar
						or Attic</label>
						</c:otherwise>
					</c:choose>
				</td>
				
				<td>
					<c:choose>
						<c:when test="${ad.furnished}">
							<form:checkbox id="field-furnished" path="furnished"  checked="checked" /><label>Furnished
							</label>
						</c:when>
						<c:otherwise>
							<form:checkbox id="field-furnished" path="furnished" /><label>Furnished</label>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td>
					<c:choose>
						<c:when test="${ad.cable}">
							<form:checkbox id="field-cable" path="cable" checked="checked" /><label>Cable TV</label>
						</c:when>
						<c:otherwise>
							<form:checkbox id="field-cable" path="cable" /><label>Cable TV</label>
						</c:otherwise>
					</c:choose>
				</td>
				
				<td>
					<c:choose>
						<c:when test="${ad.garage}">
							<form:checkbox id="field-garage" path="garage"  checked="checked" /><label>Garage
							</label>
						</c:when>
						<c:otherwise>
							<form:checkbox id="field-garage" path="garage" /><label>Garage</label>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td>
					<c:choose>
						<c:when test="${ad.internet}">
							<form:checkbox id="field-internet" path="internet"  checked="checked" /><label>WiFi available
							</label>
						</c:when>
						<c:otherwise>
							<form:checkbox id="field-internet" path="internet" /><label>WiFi available</label>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>

			
		</table>

		<br />
		<form:textarea path="roomDescription" rows="10" cols="70" value="${ad.roomDescription}" />
		<form:errors path="roomDescription" cssClass="validationErrorText" />
		
		</div>
	</fieldset>

	</td>
	
	<td>
	<fieldset class="editFieldsetThree" >
	
		<legend>Change pictures</legend>
		
		<div>
		<h3>Delete existing pictures</h3>
		<br />
		<div>
			<c:forEach items="${ad.pictures }" var="picture">
				<div class="pictureThumbnail">
					<div>
					<img src="${picture.filePath}" />
					</div>
					<button type="button" style="border-radius: 5px; background-color:#991f00;color:white" data-ad-id="${ad.id }" data-picture-id="${picture.id }">Delete</button>
				</div>
			</c:forEach>
		</div>
		<p class="clearBoth"></p>
		<br /><br />
		<hr />
		<h3>Add new pictures</h3>
		<br />
		<label for="field-pictures">Pictures</label> <input
			type="file" id="field-pictures" accept="image/*" multiple="multiple" />
		<table id="uploaded-pictures" class="styledTable">
			<tr>
				<th id="name-column">Uploaded picture</th>
				<th>Size</th>
				<th>Delete</th>
			</tr>
		</table>
		<br>
		</div>
	</fieldset>

	</td>
	
	</tr>
	<tr>

	<td>
	<fieldset class="editFieldsetThree"  >
		<legend>Add visiting times</legend>
		<div>
		
		<table>
			<tr>
				<td>
					<input type="text" id="field-visitDay" />
					
					<select id="startHour">
 					<% 
 						for(int i = 0; i < 24; i++){
 							String hour = String.format("%02d", i);
							out.print("<option value=\"" + hour + "\">" + hour + "</option>");
 						}
 					%>
					</select>
					
					<select id="startMinutes">
 					<% 
 						for(int i = 0; i < 60; i++){
 							String minute = String.format("%02d", i);
							out.print("<option value=\"" + minute + "\">" + minute + "</option>");
 						}
 					%>
					</select>
					
					<span>to&thinsp; </span>
					
					<select id="endHour">
 					<% 
 						for(int i = 0; i < 24; i++){
 							String hour = String.format("%02d", i);
							out.print("<option value=\"" + hour + "\">" + hour + "</option>");
 						}
 					%>
					</select>
					
					<select id="endMinutes">
 					<% 
 						for(int i = 0; i < 60; i++){
 							String minute = String.format("%02d", i);
							out.print("<option value=\"" + minute + "\">" + minute + "</option>");
 						}
 					%>
					</select>
			

					<div id="addVisitButton" class="smallPlusButton">+</div>
					
					<div id="addedVisits"></div>
				</td>
				
			</tr>
			
		</table>
		<br>
		
		</div>
	</fieldset>

	
	
	</td>
	<td>
	
	<fieldset id="preference" class="editFieldsetTwo" >
			<legend>Change preferences</legend>
		<div>
		<form:textarea path="preferences" rows="4" cols="70" value="${ad.preferences}" ></form:textarea>
		
		</div>
	</fieldset>
	</td>
	</tr>
	</table>

	<br>
	<div style="padding-left:30px; margin-left:auto; margin-right:auto; ">
		<a href="<c:url value='/ad?id=${ad.id}' />"> 
			<button style="background-color:#991f00;color:white" type="button">Cancel</button>
		</a>
		<button style="background-color:#ffffcc" type="submit">Submit</button>
	</div>
	
	
</form:form>


<c:import url="template/footer.jsp" />