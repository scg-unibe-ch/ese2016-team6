<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:import url="template/header.jsp" />
<!-- 
<pre><a href="/">Home</a>   &gt;   <a href="/searchAd/">Search</a>   &gt;   Results</pre>
-->

<!-- 
<script>
function validateType(form)
{
	var rent = document.getElementById('rent');
	var sale = document.getElementById('sale');
	var neither = document.getElementById('neither');
	var both = document.getElementById('both');
	var type = document.getElementById('type');
	var filtered = document.getElementById('filtered');
	
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
		type.checked = studio.checked;
	}
	filtered.checked = true;
}
</script>
-->

<!-- imports the new login window found in template/NewLoginPop.jsp -->
<!-- This must be in the body of each page in order for the login screen to work -->
<c:import url="template/NewLoginPop.jsp" />

<script src="http://maps.google.com/maps/api/js?sensor=false" type="text/javascript">
console.log(${fn:length(results)});
var addresses = new Array(${fn:length(results)});
var i = 0;
</script>

<script>
/*
 * This script takes all the resultAd divs and sorts them by a parameter specified by the user.
 * No arguments need to be passed, since the function simply looks up the dropdown selection.
 */
function sort_div_attribute() {
    //determine sort modus (by which attribute, asc/desc)
    var sortmode = $('#modus').find(":selected").val();   
    
    //only start the process if a modus has been selected
    if(sortmode.length > 0) {
    	var attname;
		
    	//determine which variable we pass to the sort function
		if(sortmode == "price_asc" || sortmode == "price_desc")
			attname = 'data-price';
	    else if(sortmode == "moveIn_asc" || sortmode == "moveIn_desc")	
			attname = 'data-moveIn';
	    else
			attname = 'data-age';
    	
		//copying divs into an array which we're going to sort
	    var divsbucket = new Array();
	    var divslist = $('div.resultAd');
	    var divlength = divslist.length;
	    for (a = 0; a < divlength; a++) {
			divsbucket[a] = new Array();
			divsbucket[a][0] = divslist[a].getAttribute(attname);
			divsbucket[a][1] = divslist[a];
			divslist[a].remove();
	    }
		
	    //sort the array
		divsbucket.sort(function(a, b) {
	    if (a[0] == b[0])
			return 0;
	    else if (a[0] > b[0])
			return 1;
        else
			return -1;
		});

	    //invert sorted array for certain sort options
		if(sortmode == "price_desc" || sortmode == "moveIn_asc" || sortmode == "dateAge_asc")
			divsbucket.reverse();
        
	    //insert sorted divs into document again
		for(a = 0; a < divlength; a++)
        	$("#resultsDiv").append($(divsbucket[a][1]));
	}
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
		
		$("#field-earliestMoveInDate").datepicker({
			dateFormat : 'dd-mm-yy'
		});
		$("#field-latestMoveInDate").datepicker({
			dateFormat : 'dd-mm-yy'
		});
	<%--	$("#field-earliestMoveOutDate").datepicker({
			dateFormat : 'dd-mm-yy'
		});
		$("#field-latestMoveOutDate").datepicker({
			dateFormat : 'dd-mm-yy'
		});--%>
		
		var map = new google.maps.Map(document.getElementById('map'), {
		      zoom: 7,
		      center: new google.maps.LatLng(46.8633639,8.213877),
		      mapTypeId: google.maps.MapTypeId.ROADMAP
		});
		
		var geocoder = new google.maps.Geocoder();
		var infowindow = new google.maps.InfoWindow();
		var marker, k;
		var address = addresses[0];
		
		console.log(address);
		
		for(var k = 0; k < addresses.length; k++) {
			var address = addresses[k];
			
		    geocoder.geocode({'address': address}, function(results, status) {
		   		if (status === google.maps.GeocoderStatus.OK) {
		      		var marker = new google.maps.Marker({
		      		map: map,
		        	position: results[0].geometry.location
		      		});
		    	} else if(status === google.maps.GeocoderStatus.OVER_QUERY_LIMIT){
		    		k--;
		    	} else {
		      		alert('Geocode was not successful for the following reason: ' + status);
		    	}
		   	});
		}
	});
</script>

<h1>Search results:</h1>

<hr />


<table style="width:50%;
	table-layout: fixed;">
<tr>
<td valign="top" style="width:400px; min-width:400px;">

<div id="map" style="width: 400px; height: 300px;"></div>

<br>

<div>
<select id="modus">
    <option value="">Sort by:</option>
    <option value="price_asc">Price (ascending)</option>
    <option value="price_desc">Price (descending)</option>
    <option value="moveIn_desc">Move-in date (earliest to latest)</option>
    <option value="moveIn_asc">Move-in date (latest to earliest)</option>
    <option value="dateAge_asc">Date created (youngest to oldest)</option>
    <option value="dateAge_desc">Date created (oldest to youngest)</option>
</select>




<button onClick="sort_div_attribute()">Sort</button>	
</div>

<form:form method="post" modelAttribute="searchForm" action="/results"
	id="filterForm" autocomplete="off">
	
	<div id="filterDiv">
		<h2>Filter results:</h2>
		
		<form>
			<c:choose>
			<c:when test="${forRent}=='checked'">
				<input type="radio" id="type-rent" name="RentSale" checked="checked"> For Rent
				<input type="radio" id="type-sale" name="RentSale"> For Sale/Auction				
			</c:when>
			<c:otherwise>
				<input type="radio" id="type-rent" name="RentSale"> For Rent
				<input type="radio" id="type-sale" name="RentSale" checked="checked"> For Sale/Auction			
			</c:otherwise>
			</c:choose>
	 		</form>
  		
  		<br />
		<label for="city">City / zip code:</label>
		<form:input type="text" name="city" id="city" path="city"
			placeholder="e.g. Bern" tabindex="3" />
		<form:errors path="city" cssClass="validationErrorText" />
		
		<br />	
		<label for="radius">Within radius of (max.):</label>
		<form:input id="radiusInput" type="number" path="radius" min="0" />
		km
		<form:errors path="radius" cssClass="validationErrorText" />
	
		<br /> 
		<label for="prize">Price (max.):</label>
		<form:input id="prizeInput" type="number" path="prize" min="0" />
		CHF
		<form:errors path="prize" cssClass="validationErrorText" />
		
		<br />
		<label for="numberOfRooms">Rooms(min.):</label>
		<form:input id="numberRoomsInput" type="number" path="numberOfRooms"
			placeholder="e.g. 5" default="1" min="1"/>
		Rooms
		<form:errors path="numberOfRooms" cssClass="validationErrorText" />
		
		<br />
	
		<hr class="slim">		
		
		<table style="width: 60%">
			<tr>
				<td><label for="earliestMoveInDate">Earliest move-in date</label></td>
				<td><label for="earliestMoveOutDate">Earliest move-out date (optional)</label></td>
			</tr>
			<tr>
				<td><form:input type="text" id="field-earliestMoveInDate"
						path="earliestMoveInDate" /></td>
				<td><form:input type="text" id="field-earliestMoveOutDate"
						path="earliestMoveOutDate" /></td>
			</tr>
			<tr>
				<td><label for="latestMoveInDate">Latest move-in date</label></td>
				<td><label for="latestMoveOutDate">Latest move-out date (optional)</label></td>
			</tr>
			<tr>
				<td><form:input type="text" id="field-latestMoveInDate"
						path="latestMoveInDate" /></td>
				<td><form:input type="text" id="field-latestMoveOutDate"
						path="latestMoveOutDate" /></td>
			</tr>
			<tr>
				<td><form:checkbox id="field-smoker" path="smokers" value="1" /><label>Smoking inside
						allowed</label></td>
				<td><form:checkbox id="field-animals" path="animals" value="1" /><label>Animals
						inside allowed</label></td>
			</tr>
			<tr>
				<td><form:checkbox id="field-garden" path="garden" value="1" /><label>Garden
						(co-use)</label></td>
				<td><form:checkbox id="field-balcony" path="balcony" value="1" /><label>Balcony
						or Patio</label></td>
			</tr>
			<tr>
				<td><form:checkbox id="field-cellar" path="cellar" value="1" /><label>Cellar
						or Attic</label></td>
				<td><form:checkbox id="field-furnished" path="furnished"
						value="1" /><label>Furnished</label></td>
			</tr>
			<tr>
				<td><form:checkbox id="field-cable" path="cable" value="1" /><label>Cable
						TV</label></td>
				<td><form:checkbox id="field-garage" path="garage" value="1" /><label>Garage</label>
				</td>
			</tr>
			<tr>
				<td><form:checkbox id="field-internet" path="internet" value="1" /><label>WiFi</label></td>
			</tr>
		</table>
			
		<button style="background-color:#991f00;color:white" type="reset">Cancel</button>
		<button style="background-color:#ffffcc" type="submit">Filter</button>	
		
	</div>
</form:form>



</td>

<!-- seperates the two columns -->

<td style="width:15px;">
<div style="width:15px;">


</div>
</td>

<td valign="top">

<c:choose>
	<c:when test="${empty results}">
		<p style="float:left; width:100%">No results found!
	</c:when>
	<c:otherwise>
		<div id="resultsDiv" class="resultsDiv" style="float:left; width:100%;">			
			<c:forEach var="ad" items="${results}">
				<div class="resultAd" data-price="${ad.prizePerMonth}" 
								data-moveIn="${ad.moveInDate}" data-age="${ad.moveInDate}">
								
				 	<table id="resultTable" >
						<tr>
							<th colspan="3">
								<h2>
									<a class="link" href="<c:url value='/ad?id=${ad.id}' />">${ad.title }</a>
								</h2>
							</th>
						</tr>
						<tr>
							<td>
								<div class="resultLeft">
									<a href="<c:url value='/ad?id=${ad.id}' />"><img
									src="${ad.pictures[0].filePath}" /></a>
								</div>
							</td>
							
							<td>
								<div class="resultMiddle">
									<p>
										<c:if test="${ad.deal=='forRent'}"> For rent</c:if>
										<c:if test="${ad.deal=='forSale'}"> 
											<c:if test="${ad.sale=='direct'}"> For sale</c:if>
											<c:if test="${ad.sale=='auction'}"> For auction</c:if>
											<c:if test="${ad.sale=='bothAuctionAndDirect'}"> For auction/sale</c:if>
										</c:if>
										
									</p>
									<p>${ad.street}, ${ad.zipcode} ${ad.city}</p>
									<p>
										<i>
											Flat
											<c:if test="${ad.numberOfRooms==0}"> with unspecified amount of rooms </c:if>
											<c:if test="${ad.numberOfRooms>0}"> with ${ad.numberOfRooms} rooms  </c:if>
										</i>
									</p>
								</div>
							</td>
						
							<td>
								<div class="resultRight">
									
									
									<c:if test="${ad.sale=='direct'}"> <h2>CHF ${ad.priceSale } <br> sale price </h2></c:if>
									<c:if test="${ad.sale=='auction'}"> <h2>CHF ${ad.currentBid } <br> current bid </h2></c:if>
									<c:if test="${ad.sale=='bothAuctionAndDirect'}"> <h2>CHF ${ad.currentBid } <br> current Bid </h2></c:if>
									
									<br /> <br />
									<fmt:formatDate value="${ad.moveInDate}" var="formattedMoveInDate"
										type="date" pattern="dd.MM.yyyy" />
									<p>Move-in date: ${formattedMoveInDate }</p>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</c:forEach>
		</div>
	</c:otherwise>
</c:choose>

</td>
</tr>
</table>

<c:import url="template/footer.jsp" />