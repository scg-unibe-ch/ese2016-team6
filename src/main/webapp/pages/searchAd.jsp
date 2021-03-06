<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:import url="template/header.jsp" />

<!-- <pre><a href="/">Home</a>   &gt;   Search</pre> -->

<script>
	$(document).ready(function() {
		$("#city").autocomplete({
			minLength : 1
		});
		$("#city").autocomplete({
			source : <c:import url="getzipcodes.jsp" />
		});
		$("#city").autocomplete("option", {
			enabled : true,
			autoFocus : true
		});
		
		var price = document.getElementById('price');
		var radius = document.getElementById('radiusInput');
		
		var roomNumbers = document.getElementById('numberRoomsInput');
		
		
		if(price.value == null || price.value == "" || price.value == "0")
			price.value = "500";
		if(radius.value == null || radius.value == "" || radius.value == "0")
			radius.value = "5";
		
		
		if(roomNumbers.value == null || roomNumbers.value == "" || roomNumbers.value == "0")
			roomNumbers.value = "1";	
	});
</script>
<script>
$(document).ready(function() {
	
	$("#type-rent").click();
	
	$("#type-sale").on("click", function(){
		document.getElementById('forSale').checked = true;
		document.getElementById('forRent').checked = false;
	});

	$("#type-rent").on("click", function(){
		document.getElementById('forRent').checked = true;
		document.getElementById('forSale').checked = false;
	});
	
	if (document.getElementById('forSale').checked) {
		$("#type-sale").prop('checked', true);
	} else {
		$("#type-rent").prop('checked', true);
	}
});	
</script>
<script> function wasSale() {
	return document.getElementById('forSale').checked;
}
</script>


<!-- imports the new login window found in template/NewLoginPop.jsp -->
<!-- This must be in the body of each page in order for the login screen to work -->
<c:import url="template/NewLoginPop.jsp" />

<h1>Search for an ad</h1>
<hr />

<form:form method="post" modelAttribute="searchForm" action="/results"
	id="searchForm" autocomplete="off">

	<fieldset>
			<form:checkbox id="forRent" style="display:none" name="forRent" path="forRent" checked="checked"/>
			<form:checkbox id="forSale" style="display:none" name="forSale" path="forSale"/>
			<form>
			<%-- that needs to be fixed --%>
			<%-- document.getElementById('forSale').checked --%>
			
				<input type="radio" id="type-rent" name="RentSale"> For Rent
				<input type="radio" id="type-sale" name="RentSale"> For Sale/Auction				
			
			</form>
		<br />
		
		<label for="city">City / zip code:</label>
		<form:input type="text" name="city" id="city" path="city"
			placeholder="e.g. Bern" tabindex="3" />
		<form:errors path="city" cssClass="validationErrorText" />
		

		<label for="radiusInput">Within radius of (max.):</label>
		<form:input id="radiusInput" type="number" path="radius" min="0" />
		km
		<form:errors path="radius" cssClass="validationErrorText" />
		
		
		<br /> <label for="price">Price (max.):</label>
		<form:input id="price" type="number" path="price" min="1" />
		CHF
		<form:errors path="price" cssClass="validationErrorText" />
		<br />
		
		<label for="numberRoomsInput">Rooms (min.):</label>
		
		<form:input id="numberRoomsInput" type="number" path="numberOfRooms"
			placeholder="e.g. 5" min="1"/>
		Rooms
		<form:errors path="numberOfRooms" cssClass="validationErrorText" />
		
		<br />
		
		<button style="background-color:#991f00;color:white" type="reset" class="btn btn-default" tabindex="8">Cancel</button>
		<button style="background-color:#ffffcc" type="submit" class="btn btn-default" tabindex="7" >Search</button>
		
	</fieldset>

</form:form>

<c:import url="template/footer.jsp" />