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

<script>
$(document).ready(function() {
	$("#type-sale").on("click", function(){
		document.getElementById('forSale').checked = true;
		document.getElementById('forRent').checked = false;
	});

	$("#type-rent").on("click", function(){
		document.getElementById('forRent').checked = true;
		document.getElementById('forSale').checked = false;
	});
});	
</script>

<script>
function validateType(form)
{	
	var minsize = document.getElementById('minSize');
	var maxsize = document.getElementById('maxSize');
	var isValid = document.getElementById('isValid');
	if(maxsize.value < minsize.value) {
		document.getElementById('isValid').checked = false;
	} else {
		document.getElementById('isValid').checked = true;
	}
}
</script>

<script>
function rentSaleOfAlert(alert) {
	if(forSale.checked)
		return "For Sale"
	else
		return "For Rent"
}	
</script>
	
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
			radius.value = "5";
	});
</script>

<h1>Create and manage alerts</h1>
<hr />

<h2>Create new alert</h2><br />
<form:form method="post" modelAttribute="alertForm" action="/profile/alerts"
	id="alertForm" autocomplete="off">

			<form:checkbox id="forRent" style="display:none" name="forRent" path="forRent"/>
			<form:checkbox id="forSale" style="display:none" name="forSale" path="forSale"/>
	
	<fieldset>		
		<form>
    		<input type="radio" id="type-rent" name="RentSale" checked="checked"> For Rent
   			<input type="radio" id="type-sale" name="RentSale"> For Sale
  		</form>
		<br />
		
		<label for="city">City / zip code:</label>
		<form:input type="text" name="city" id="city" path="city"
			placeholder="e.g. Bern" tabindex="3" />
		<form:errors path="city" cssClass="validationErrorText" />
		
		<label for="radius">Within radius of (max.):</label>
		<form:input id="radiusInput" type="number" path="radius" step="1" />
		km
		<form:errors path="radius" cssClass="validationErrorText" />
		<br /> 
		
		<label for="price">Price (max.):</label>
		<form:input id="priceInput" type="number" path="price" step="50" />
		CHF
		<form:errors path="price" cssClass="validationErrorText" />
		<br />
		
		<label for="numberOfRooms">Number of Rooms (min.):</label>
		<form:input id="roomsInput" type="number" path="numberOfRooms"
			placeholder="e.g. 3" step="1"  default="1"/>
		<form:errors path="numberOfRooms" cssClass="validationErrorText" />
		<br />
		
		<label for="minSize">Size (min.):</label>
		<form:input id="minSize" type="number" path="minSize" placeholder="e.g. 0" step="5" default="0"/>
		Square Meters
		<form:errors path="minSize" cssClass="validationErrorText" />
		
		<label for="maxSize">Size (max.):</label>
		<form:input id="maxSize" type="number" path="maxSize" placeholder="e.g. 1" step="5" default="1000000"/>
		Square Meters
		<form:errors path="maxSize" cssClass="validationErrorText" /> 
		
		<form:checkbox id="isValid" style="display:none" name="isValid" path="isValid" readonly="readonly"/>
		<form:errors path="isValid" cssClass="validationErrorText" />
		
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
				<th>Rent/Sale</th>
				<th>City</th>
				<th>Radius</th>
				<th>max. Price</th>
				<th>min. Number of Rooms</th>
				<th>Size</th>
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
				</td> -->
				
				<td>
				<c:choose>
					<c:when test="${alert.forSale}">
						For Sale
					</c:when>
					<c:otherwise>
						For Rent
					</c:otherwise>
				</c:choose>
				</td>
				
				<td>${alert.city}</td>
				<td>${alert.radius} km</td>
				<td>${alert.price} Chf</td>
				<td>${alert.numberOfRooms}</td>
				<td>
					<c:choose>
						<c:when test="${alert.minSize != 0 && (alert.maxSize == 1000000 || alert.maxSize == 0)}">
							greater than ${alert.minSize} Square Meters
						</c:when>
						<c:when test="${alert.minSize == 0 && (alert.maxSize == 1000000 || alert.maxSize == 0)}">
							all
						</c:when>
						<c:when test="${alert.minSize == alert.maxSize}">
							${alert.maxSize} Square Meters
						</c:when>						
						<c:otherwise>
							${alert.minSize} - ${alert.maxSize} Square Meters
						</c:otherwise>
					</c:choose>
				</td>
				<td><button class="deleteButton" data-id="${alert.id}" onClick="deleteAlert(this)">Delete</button></td>
			</tr>
		</c:forEach>
		</table>
	</c:otherwise>
</c:choose>
</div>

<c:import url="template/footer.jsp" />