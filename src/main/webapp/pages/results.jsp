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

<!-- imports the new login window found in template/NewLoginPop.jsp -->
<!-- This must be in the body of each page in order for the login screen to work -->
<c:import url="template/NewLoginPop.jsp" />

<script src="http://maps.google.com/maps/api/js?sensor=false" type="text/javascript"></script>

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

console.log(${fn:length(results)});
var addresses = new Array(${fn:length(results)});
var i = 0;

	$(document).ready(function() {

		if (document.getElementById('forSale').checked) {
			$("#type-sale").prop('checked', true);
		} else {
			$("#type-rent").prop('checked', true);
		}
		
		$("#type-sale").click(function() {
			
			$("#forRent").prop('checked', false);
			$("#forSale").prop('checked', true);
			
		});
		
		
		$("#type-rent").click(function() {
			$("#forRent").prop('checked', true);
			$("#forSale").prop('checked', false);
			
		});
		
		$("#moreFilterCriteria").click(function() {
			document.getElementById('moreFilterCriteria').style.visibility = "hidden";
			document.getElementById('line').style.display = "block";
			document.getElementById('additionalCriteria').style.display = "block";
			document.getElementById('hideMoreCriteria').style.display = "block";
		});
		
		$("#hideMoreCriteria").click(function() {
			document.getElementById('moreFilterCriteria').style.visibility = "visible";
			document.getElementById('line').style.display = "none";
			document.getElementById('additionalCriteria').style.display = "none";
			document.getElementById('hideMoreCriteria').style.display = "none";
		});
		
		$("#showMap").click(function() {
			document.getElementById('showMap').style.display = "none";
			document.getElementById('map').style.display = "";
			document.getElementById('hideMap').style.display = "block";
		});
		
		$("#hideMap").click(function() {
			document.getElementById('showMap').style.display = "block";
			document.getElementById('map').style.display = "none";
			document.getElementById('hideMap').style.display = "none";
		});
		
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
			var errorShown = 0;
			
		    geocoder.geocode({'address': address}, function(results, status) {
		   		if (status === google.maps.GeocoderStatus.OK) {
		      		var marker = new google.maps.Marker({
		      		map: map,
		        	position: results[0].geometry.location
		      		});
		    	} else if(status === google.maps.GeocoderStatus.OVER_QUERY_LIMIT){
		    		k--;
		    	} else {
		      		if(errorShown=0){
						alert('Geocode was not successful for the following reason: ' + status);
						errorShown=1;
					}
				}
		   	});
		}
	});
</script>

<h1>Search results:</h1>

<hr />


<table style="width:100%;
	table-layout: fixed;">
<tr>
<td valign="top" style="width:350px; min-width:400px;">


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
		
		<form:checkbox id="forRent" style="display:none" name="forRent" path="forRent"/>
		<form:checkbox id="forSale" style="display:none" name="forSale" path="forSale"/>
		
		<form>
				<input type="radio" id="type-rent" name="RentSale"> For Rent
				<input type="radio" id="type-sale" name="RentSale"> For Sale/Auction				
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
		<label for="price">Price (max.):</label>
		<form:input id="priceInput" type="number" path="price" min="0" />
		CHF
		<form:errors path="price" cssClass="validationErrorText" />
		
		<br />
		<label for="numberOfRooms">Rooms(min.):</label>
		<form:input id="numberRoomsInput" type="number" path="numberOfRooms"
			placeholder="e.g. 5" default="1" min="1"/>
		Rooms
		<form:errors path="numberOfRooms" cssClass="validationErrorText" />
		
		<br />
			
		<hr class="slim" id="line" style="display:none">		
		
		<table id="additionalCriteria" style="width: 100%; display:none">
			<tr>
				<td><label for="earliestMoveInDate">Earliest move-in date</label></td>
				<td><form:input type="text" id="field-earliestMoveInDate"
						path="earliestMoveInDate" /></td>
			</tr>
			<tr>
				<td><label for="latestMoveInDate">Latest move-in date</label></td>
				<td><form:input type="text" id="field-latestMoveInDate"
						path="latestMoveInDate" /></td>
			</tr>
			<tr>
				<td><label for="earliestMoveOutDate">Earliest move-out date (optional)</label></td>
				<td><form:input type="text" id="field-earliestMoveOutDate"
						path="earliestMoveOutDate" /></td>
			</tr>
			<tr>
				<td><label for="latestMoveOutDate">Latest move-out date (optional)</label></td>
				<td><form:input type="text" id="field-latestMoveOutDate"
						path="latestMoveOutDate" /></td>
			</tr>
			<tr>
				<td><form:checkbox id="field-smoker" path="smokers" value="1" /><label>Smoking inside
						allowed</label></td>
				<td><form:checkbox id="field-garden" path="garden" value="1" /><label>Garden
						(co-use)</label></td>
			</tr>
			<tr>
				<td><form:checkbox id="field-cellar" path="cellar" value="1" /><label>Cellar
						or Attic</label></td>
				<td><form:checkbox id="field-cable" path="cable" value="1" /><label>Cable
						TV</label></td>						
			</tr>
			<tr>
				<td><form:checkbox id="field-animals" path="animals" value="1" /><label>Animals
						inside allowed</label></td>
				<td><form:checkbox id="field-balcony" path="balcony" value="1" /><label>Balcony
						or Patio</label></td>
			</tr>
			<tr>
				<td><form:checkbox id="field-furnished" path="furnished"
						value="1" /><label>Furnished</label></td>
				<td><form:checkbox id="field-garage" path="garage" value="1" /><label>Garage</label>
				</td>
			</tr>
			<tr>
				<td><form:checkbox id="field-internet" path="internet" value="1" /><label>WiFi</label></td>
			</tr>
		</table>
		
		<button style="background-color:#991f00;color:white" type="reset">Cancel</button>
		<button style="background-color:#ffffcc" type="submit">Filter</button>
		<button id="hideMoreCriteria" type="button" style="float: right; display: none;">Hide Filter Criteria</button>
		<button id="moreFilterCriteria" type="button" style="float: right;">More Filter Criteria</button>	
	</div>
</form:form>

</td>
<!-- seperates the two columns -->

<td style="width:60px;">
<div style="width:60px;">
</div>
</td>

<td rowspan="2" valign="top">

<button id="showMap" type="button" style="float: left; display: none;">Show the Map</button>
<button id="hideMap" type="button" style="float: left;">Hide the Map</button>

<div id="map" style="width: 800px; height: 300px; float:left"></div>

<c:choose>
	<c:when test="${empty results}">
		<p style="float:left; align:center; width:100%">No results found!
	</c:when>
	<c:otherwise>
		<div id="resultsDiv" class="resultsDiv" style="float:left; align:center; width:100%;">			
			<c:forEach var="ad" items="${results}">
				<div class="resultAdSearch" data-price="${ad.price}" 
								data-moveIn="${ad.moveInDate}" data-age="${ad.moveInDate}">
								
				 	<table id="resultTable" >
						<tr>
							<th colspan="3">
								<h2>
									<a class="link" style="float:left;" href="<c:url value='/ad?id=${ad.id}' />">${ad.title }</a>
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
									<c:if test="${ad.deal=='forRent'}"> <h2>CHF ${ad.priceRent}</h2></c:if>
									<c:if test="${ad.deal=='forSale'}">
											<c:if test="${ad.sale=='direct'}"> <h2>CHF ${ad.priceSale} <br> sale price </h2></c:if>
											<c:if test="${ad.sale=='auction'}"> <h2>CHF ${ad.currentBid} <br> current bid </h2></c:if>
											<c:if test="${ad.sale=='bothAuctionAndDirect'}"> <h3>CHF ${ad.priceSale} sale price </h3> <h3>CHF ${ad.currentBid } current Bid </h3></c:if>
											</c:if>
									<br /> <br />
									<fmt:formatDate value="${ad.moveInDate}" var="formattedMoveInDate"
										type="date" pattern="dd.MM.yyyy" />
									<p>Move-in date: ${formattedMoveInDate }</p>
								</div>
							</td>

							<script>
								addresses[i] = "${ad.street} ${ad.zipcode} ${ad.city}";
								i++;
							</script>

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