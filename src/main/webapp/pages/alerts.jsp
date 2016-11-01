<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:import url="template/header.jsp" />

<pre><a href="/">Home</a>   &gt;   Alerts</pre>

<script>
function deleteAlert(button) {
	var id = $(button).attr("data-id");
	$.get("/profile/alerts/deleteAlert?id=" + id, function(){
		$("#alertsDiv").load(document.URL + " #alertsDiv");
	});
}
</script>

<!-- <script>
function validateType(form)
{
	var room = document.getElementById('room');
	var studio = document.getElementById('studio');
	var neither = document.getElementById('neither');
	var both = document.getElementById('both');
	
	if(room.checked && studio.checked) {
		both.checked = true;
		neither.checked = false;
	}
	else if(!room.checked && !studio.checked) {
		both.checked = false;
		neither.checked = true;
	}
	else {
		both.checked = false;
		neither.checked = false;
	}
	
	
	var rent = document.getElementById('rent');
	var sale = document.getElementById('sale');
	var neitherRentSale = document.getElementById('neitherRentSale');
	var bothRentAndSale = document.getElementById('bothRentAndSale');
	
	if(rent.checked && sale.checked) {
		bothRentAndSale.checked = true;
		neitherRentSale.checked = false;
	}
	else if(!rent.checked && !sale.checked) {
		bothRentAndSale.checked = false;
		neitherRentSale.checked = true;
	}
	else {
		bothRentAndSale.checked = false;
		neitherRentSale.checked = false;
	}
}
</script> -->

<!-- <script>
function typeOfAlert(alert) {
	if(alert.getBothRoomAndStudio())
		return "Both"
	else if(alert.getStudio())
		return "Studio"
	else
		return "Room"
}	
<<<<<<< HEAD
</script> -->
=======
</script>

<script>
function rentSaleOfAlert(alert) {
	if(alert.getBothRentAndSale())
		return "Both"
	else if(alert.getForSale())
		return "For Sale"
	else
		return "For Rent"
}	
</script>
>>>>>>> alertcriterias
	
<script>
	$(document).ready(function() {
		$("#city").autocomplete({
			minLength : 2
		});
		$("#city").autocomplete({
			source : <c:import url="getzipcodes.jsp" />
		});
		$("#city").autocomplete("option", {
			enabled : true,
			autoFocus : true
		});
		
		var price = document.getElementById('priceInput');
		var radius = document.getElementById('radiusInput');
		
		if(price.value == null || price.value == "" || price.value == "0")
			price.value = "500";
		if(radius.value == null || radius.value == "" || radius.value == "0")
			radius.value = "1";
	});
</script>

<h1>Create and manage alerts</h1>
<hr />

<h2>Create new alert</h2><br />
<form:form method="post" modelAttribute="alertForm" action="/profile/alerts"
	id="alertForm" autocomplete="off">

	<fieldset>
		<!-- <form:checkbox name="room" id="room" path="room" /><label>Room</label>
		<form:checkbox name="studio" id="studio" path="studio" /><label>Studio</label>
		
		<form:checkbox style="display:none" name="neither" id="neither" path="noRoomNoStudio" />
		<form:checkbox style="display:none" name="both" id="both" path="bothRoomAndStudio" />
		<form:errors path="noRoomNoStudio" cssClass="validationErrorText" /><br /> -->
		
		<form:checkbox name="rent" id="rent" path="forRent" /><label>For Rent</label>
		<form:checkbox name="sale" id="sale" path="forSale" /><label>For Sale</label>
		
		<form:checkbox style="display:none" name="neitherRentSale" id="neitherRentSale" path="noRentNoSale" />
		<form:checkbox style="display:none" name="bothRentAndSale" id="bothRentAndSale" path="bothRentAndSale" />
		<form:errors path="noRentNoSale" cssClass="validationErrorText" /><br />
		
		<label for="city">City / zip code:</label>
		<form:input type="text" name="city" id="city" path="city"
			placeholder="e.g. Bern" tabindex="3" />
		<form:errors path="city" cssClass="validationErrorText" />
		
		<label for="radius">Maximum radius of search :</label>
		<form:input id="radiusInput" type="number" path="radius"
			placeholder="e.g. 5" step="1" />
		km
		<form:errors path="radius" cssClass="validationErrorText" />
		<br /> <label for="price">Maximum price :</label>
		<form:input id="priceInput" type="number" path="price"
			placeholder="e.g. 5" step="50" />
		CHF
		<form:errors path="price" cssClass="validationErrorText" />
		<br />
		
		<label for="numberOfRooms">Number of Rooms (min.):</label>
		<form:input id="roomsInput" type="number" path="numberOfRooms"
			placeholder="e.g. 3" step="1" />
		
		<br />

		<button type="submit" tabindex="7" onClick="validateType(this.form)">Subscribe</button>
		<button type="reset" tabindex="8">Cancel</button>
	</fieldset>

</form:form> <br />
<h2>Your active alerts</h2>

<div id="alertsDiv" class="alertsDiv">			
<c:choose>
	<c:when test="${empty alerts}">
		<p>You currently aren't subscribed to any alerts.
	</c:when>
	<c:otherwise>
		<table class="styledTable" id="alerts">
			<thead>
			<tr>
				<th>Type</th>
				<th>Rent/Sale</th>
				<th>City</th>
				<th>Radius</th>
				<th>max. Price</th>
				<th>min. Number of Rooms</th>
				<th>Action</th>
			</tr>
			</thead>
		<c:forEach var="alert" items="${alerts}">
			<tr>
				<!-- <td>
				<c:choose>
					<c:when test="${alert.bothRoomAndStudio}">
						Both
					</c:when>
					<c:when test="${alert.studio}">
						Studio
					</c:when>
					<c:otherwise>
						Room
					</c:otherwise>
				</c:choose>
<<<<<<< HEAD
				</td> -->
=======
				</td>
				<td>
				<c:choose>
					<c:when test="${alert.bothRentAndSale}">
						Both
					</c:when>
					<c:when test="${alert.forSale}">
						For Sale
					</c:when>
					<c:otherwise>
						For Rent
					</c:otherwise>
				</c:choose>
				</td>
>>>>>>> alertcriterias
				<td>${alert.city}</td>
				<td>${alert.radius} km</td>
				<td>${alert.price} Chf</td>
				<td>${alert.numberOfRooms}</td>
				<td><button class="deleteButton" data-id="${alert.id}" onClick="deleteAlert(this)">Delete</button></td>
			</tr>
		</c:forEach>
		</table>
	</c:otherwise>
</c:choose>
</div>

<c:import url="template/footer.jsp" />