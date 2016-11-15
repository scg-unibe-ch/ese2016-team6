<%@page import="ch.unibe.ese.team6.model.Ad"%>
<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<!-- check if user is logged in -->
<security:authorize var="loggedIn" url="/profile" />

<c:import url="template/header.jsp" />

<pre><a href="/">Home</a>   &gt;   <a href="/profile/myRooms">My Rooms</a>   &gt;   Ad Description</pre>

<script src="/js/image_slider.js"></script>
<script src="/js/adDescription.js"></script>

<script>
	var shownAdvertisementID = "${shownAd.id}";
	var shownAdvertisement = "${shownAd}";
	
	function attachBookmarkClickHandler(){
		$("#bookmarkButton").click(function() {
			
			$.post("/bookmark", {id: shownAdvertisementID, screening: false, bookmarked: false}, function(data) {
				$('#bookmarkButton').replaceWith($('<a class="right" id="bookmarkedButton">' + "Bookmarked" + '</a>'));
				switch(data) {
				case 0:
					alert("You must be logged in to bookmark ads.");
					break;
				case 1:
					// Something went wrong with the principal object
					alert("Return value 1. Please contact the WebAdmin.");
					break;
				case 3:
					$('#bookmarkButton').replaceWith($('<a class="right" id="bookmarkedButton">' + "Bookmarked" + '</a>'));
					break;
				default:
					alert("Default error. Please contact the WebAdmin.");	
				}
				
				attachBookmarkedClickHandler();
			});
		});
	}
	
	function attachBookmarkedClickHandler(){
		$("#bookmarkedButton").click(function() {
			$.post("/bookmark", {id: shownAdvertisementID, screening: false, bookmarked: true}, function(data) {
				$('#bookmarkedButton').replaceWith($('<a class="right" id="bookmarkButton">' + "Bookmark Ad" + '</a>'));
				switch(data) {
				case 0:
					alert("You must be logged in to bookmark ads.");
					break;
				case 1:
					// Something went wrong with the principal object
					alert("Return value 1. Please contact the WebAdmin.");
					break;
				case 2:
					$('#bookmarkedButton').replaceWith($('<a class="right" id="bookmarkButton">' + "Bookmark Ad" + '</a>'));
					break;
				default:
					alert("Default error. Please contact the WebAdmin.");
					
				}			
				attachBookmarkClickHandler();
			});
		});
	}

	$(document).ready(function() {
		attachBookmarkClickHandler();
		attachBookmarkedClickHandler();
		
		$.post("/bookmark", {id: shownAdvertisementID, screening: true, bookmarked: true}, function(data) {
			if(data == 3) {
				$('#bookmarkButton').replaceWith($('<a class="right" id="bookmarkedButton">' + "Bookmarked" + '</a>'));
				attachBookmarkedClickHandler();
			}
			if(data == 4) {
				$('#shownAdTitle').replaceWith($('<h1>' + "${shownAd.title}" + '</h1>'));
			}
		});
		
		$("#newMsg").click(function(){
			$("#content").children().animate({opacity: 0.4}, 300, function(){
				$("#msgDiv").css("display", "block");
				$("#msgDiv").css("opacity", "1");
			});
		});
		
		$("#messageCancel").click(function(){
			$("#msgDiv").css("display", "none");
			$("#msgDiv").css("opacity", "0");
			$("#content").children().animate({opacity: 1}, 300);
		});
		
		$("#messageSend").click(function (){
			if($("#msgSubject").val() != "" && $("#msgTextarea").val() != ""){
				var subject = $("#msgSubject").val();
				var text = $("#msgTextarea").val();
				var recipientEmail = "${shownAd.user.username}";
				$.post("profile/messages/sendMessage", {subject : subject, text: text, recipientEmail : recipientEmail}, function(){
					$("#msgDiv").css("display", "none");
					$("#msgDiv").css("opacity", "0");
					$("#msgSubject").val("");
					$("#msgTextarea").val("");
					$("#content").children().animate({opacity: 1}, 300);
				})
			}
		});
	});
		
</script>


<!-- format the dates -->
<fmt:formatDate value="${shownAd.moveInDate}" var="formattedMoveInDate"
	type="date" pattern="dd.MM.yyyy" />
<fmt:formatDate value="${shownAd.creationDate}" var="formattedCreationDate"
	type="date" pattern="dd.MM.yyyy" />
	
<c:choose>
	<c:when test="${empty shownAd.moveOutDate }">
		<c:set var="formattedMoveOutDate" value="unlimited" />
	</c:when>
	<c:otherwise>
		<fmt:formatDate value="${shownAd.moveOutDate}"
			var="formattedMoveOutDate" type="date" pattern="dd.MM.yyyy" />
	</c:otherwise>
</c:choose>


<h1 id="shownAdTitle">${shownAd.title}
	<c:choose>
		<c:when test="${loggedIn}">
			<a class="right" id="bookmarkButton">Bookmark Ad</a>
		</c:when>
	</c:choose>
</h1>

<tr>
	<td><i><b><label id="formattedCreationDate">Ad created on : </i>${formattedCreationDate}</label></b></td>
</tr>

<hr />

<section>
	<c:choose>
		<c:when test="${loggedIn}">
			<c:if test="${loggedInUserEmail == shownAd.user.username }">
				<a href="<c:url value='/profile/editAd?id=${shownAd.id}' />">
					<button type="button">Edit Ad</button>
				</a>
			</c:if>
		</c:when>
	</c:choose>
	<br>
	<br>

	<table id="adDescTable" class="adDescDiv">
		
		<%--removed because room/studio difference no longer important
			<td><h2>Type</h2></td>
			<td>
				<c:choose>
					<c:when test="${shownAd.studio}">Studio</c:when>
					<c:otherwise>Room</c:otherwise>
				</c:choose>
			</td>

		--%>
		
		<tr>
			<td><h2>Status : </h2></td>
			<td>
				<c:choose>
					<c:when test="${shownAd.rent}">For rent </c:when>
					<c:otherwise>For sale</c:otherwise>
				</c:choose>
			</td>
		</tr>

		<tr>
			<td><h2>Address :</h2></td>
			<td>
				<a class="link" href="http://maps.google.com/?q=${shownAd.street}, ${shownAd.zipcode}, ${shownAd.city}">${shownAd.street},
						${shownAd.zipcode} ${shownAd.city}</a>
			</td>
		</tr>
		
		<%-- 
		<tr>
			<td><h2>Price</h2></td>
			<td>${shownAd.prizePerMonth}&#32;CHF</td>
		</tr>
		--%>
		
		<tr>
			<td><h2>Area :</h2></td>
			<td>${shownAd.squareFootage}&#32;m²</td>
		</tr>
		
		<tr>
			<td><h2>Number of Rooms :</h2></td>
			<td>${shownAd.numberOfRooms}</td>
		</tr>
		
		<tr>
			<td><h2>Available from : </h2></td>
			<td>${formattedMoveInDate}</td>
		</tr>
		
		<tr>
			<td><h2>To :</h2></td>
			<td>${formattedMoveOutDate}</td>
		</tr>

		
		<%--removed because room/studio difference no longer important
		<c:if test="${shownAd.studio}">
  		<tr>
  			<td><h2>Number of Rooms</h2></td>
 			<td>${shownAd.numberOfRooms}</td>
 			<c:if test="${shownAd.numberOfRooms>0}">
 				<td>${shownAd.numberOfRooms}</td>
 			</c:if>
 			
 			<c:if test="${shownAd.numberOfRooms==0}">
 				<td>unspecified</td>
 			</c:if>
 			
  		</tr>
 		</c:if>
		--%>
		
		<tr>
			<td><h2>Ad created on</h2></td>
			<td>${formattedCreationDate}</td>
		</tr>
	</table>
</section>

<div id="image-slider">
	<div id="left-arrow">
		<img src="/img/left-arrow.png" />
	</div>
	<div id="images">
		<c:forEach items="${shownAd.pictures}" var="picture">
			<img src="${picture.filePath}" />
		</c:forEach>
	</div>
	<div id="right-arrow">
		<img src="/img/right-arrow.png" />
	</div>
</div>

<hr class="clearBoth" />

<!--must depend on the kind of deal-->

<table style="width:100%; border-collapse: separate; border-spacing: 0px 10px;">
	<tr>
		<td style="width:50%;">	
			<div class="adDescDiv">
				<h2>Price corner</h2>
				
				<%-- note: to disable the ifs just add ||true inside brackets after the ' and before the } --%>
				<%-- only shows this part if property for rent --%>
				<c:if test="${shownAd.rent==true}">
					<p><h3><label>If for rent, rental charges (CHF per month) : </label>${shownAd.prizePerMonth}</h3></p>
				</c:if>
				
				<%-- only shows this part if property for sale --%>
				<c:if test="${shownAd.rent==false}">
					<p><h3><label>If for sale (CHF) :</label></h3></p>
					
					
						<%-- only shows this part if property for directsale --%>
						<c:if test="${shownAd.sale=='direct'||shownAd.sale=='bothAuctionAndDirect'}">
							<p><h3><label>- price for a direct sale : </label>${shownAd.priceSale}</h3></p>
						</c:if>
						
						<%-- only shows this part if property for auction --%>
						<c:if test="${shownAd.sale=='auction'||shownAd.sale=='bothAuctionAndDirect'}">
							<p><h3><label>- current bid (auction) : </label>${shownAd.initialBid}</h3></p>
							</br>
					
							<%-- This gets the sum of the current bid and the increment --%>
									<%!
									int cBid = 0,
										inc = 0,
										finalMinBid = 0;
									%>
									<%
									try{
										cBid = Integer.parseInt("${shownAd.currentBid}");
									 }
										catch (Exception e){
											
										}
									try{
										cBid = Integer.parseInt("${shownAd.increment}");
									 }
										catch (Exception e){
											
										}
										
									finalMinBid=cBid+inc;
									%>
					
					
					
							<p><label >Make a higher bid :</label>
							<%--<form:input id="field-currentBid" type="number" path="currentBid" value=<%=finalMinBid%> min="<%=finalMinBid%>"/></p>	
							--%>
							<button type="submit">Submit</button></p>
						</c:if>
				</c:if>
			</div>
		</td>


		<td style="width:50%;">
			<table id="advertiserTable" class="adDescDiv" style="width:93%;">
				<tr>
					<td><h2>Advertiser</h2><br /></td>
				</tr>

				<tr>
					<td><c:choose>
							<c:when test="${shownAd.user.picture.filePath != null}">
								<img src="${shownAd.user.picture.filePath}">
							</c:when>
							<c:otherwise>
								<img src="/img/avatar.png">
							</c:otherwise>
						</c:choose></td>
					
					<td>${shownAd.user.username}</td>
					
					<td id="advertiserEmail">
					<c:choose>
						<c:when test="${loggedIn}">
							<a href="/user?id=${shownAd.user.id}"><button type="button">Visit profile</button></a>
						</c:when>
						<c:otherwise>
							<a href="/login"><button class="thinInactiveButton" type="button">Login to visit profile</button></a>
						</c:otherwise>
					</c:choose>

					<td>
						<form>
							<c:choose>
								<c:when test="${loggedIn}">
									<c:if test="${loggedInUserEmail != shownAd.user.username }">
										<button id="newMsg" type="button">Contact Advertiser</button>
									</c:if>
								</c:when>
								<c:otherwise>
									<a href="/login"><button class="thinInactiveButton" type="button">Login to contact advertiser</button></a>
								</c:otherwise>
							</c:choose>
						</form>
					</td>
				</tr>
			</table>
		</td>
	</tr>

	<tr>
		<td>
			<div class="adDescDiv">
				<h2>Room Description</h2>
				<p>${shownAd.roomDescription}</p>
			</div>
		</td>

		<td>
			<div class="adDescDiv">
				<h2>Location details</h2>
				<table>
					<tr>
						<td>Proximity to Public Transport: ${shownAd.proximityToPublicTransport} meters</td>
					</tr>
					<tr>
						<td>Proximity to School: ${shownAd.proximityToSchool} meters</td>
					</tr>
					<tr>
						<td>Proximity to Supermarket: ${shownAd.proximityToSupermarket} meters</td>
					</tr>
					<tr>
						<td>Proximity to Night Life: ${shownAd.proximityToNightlife} meters</td>
					</tr>
				</table>
			</div>
		</td>
	</tr>

	<tr>
		<td>
			<div class="adDescDiv">
				<h2>Preferences</h2>
				<p>${shownAd.preferences}</p>
			</div>
		</td>

		<td>
			<div id="visitList" class="adDescDiv">
				<h2>Visiting times</h2>
				<table>
					<c:forEach items="${visits }" var="visit">
						<tr>
							<td>
								<fmt:formatDate value="${visit.startTimestamp}" pattern="dd-MM-yyyy " />
								&nbsp; from
								<fmt:formatDate value="${visit.startTimestamp}" pattern=" HH:mm " />
								until
								<fmt:formatDate value="${visit.endTimestamp}" pattern=" HH:mm" />
							</td>
							<td><c:choose>
									<c:when test="${loggedIn}">
										<c:if test="${loggedInUserEmail != shownAd.user.username}">
											<button class="thinButton" type="button" data-id="${visit.id}">Send
												enquiry to advertiser</button>
										</c:if>
									</c:when>
									<c:otherwise>
										<a href="/login"><button class="thinInactiveButton" type="button"
											data-id="${visit.id}">Login to send enquiries</button></a>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</td>
	</tr>

	<tr>
		<td>
			<table id="checkBoxTable" class="adDescDiv" style="width:93%">
				<tr>
					<td><h3>Smoking inside allowed</h3></td>
					<td>
						<c:choose>
							<c:when test="${shownAd.smokers}"><img src="/img/check-mark.png"></c:when>
							<c:otherwise><img src="/img/check-mark-negative.png"></c:otherwise>
						</c:choose>
					</td>
				
					<td style="padding-left:30px"><h3>Animals allowed</h3></td>
					<td>
						<c:choose>
							<c:when test="${shownAd.animals}"><img src="/img/check-mark.png"></c:when>
							<c:otherwise><img src="/img/check-mark-negative.png"></c:otherwise>
						</c:choose>
					</td>
				</tr>
		
				<tr>
					<td><h3>Furnished Room</h3></td>
					<td>
						<c:choose>
							<c:when test="${shownAd.furnished}"><img src="/img/check-mark.png"></c:when>
							<c:otherwise><img src="/img/check-mark-negative.png"></c:otherwise>
						</c:choose>
					</td>
				
					<td style="padding-left:30px"><h3>WiFi available</h3></td>
					<td>
						<c:choose>
							<c:when test="${shownAd.internet}"><img src="/img/check-mark.png"></c:when>
							<c:otherwise><img src="/img/check-mark-negative.png"></c:otherwise>
						</c:choose>
					</td>
				</tr>
		
				<tr>
					<td><h3>Cable TV</h3></td>
					<td>
						<c:choose>
							<c:when test="${shownAd.cable}"><img src="/img/check-mark.png"></c:when>
							<c:otherwise><img src="/img/check-mark-negative.png"></c:otherwise>
						</c:choose>
					</td>
				
					<td style="padding-left:30px"><h3>Garage</h3></td>
					<td>
						<c:choose>
							<c:when test="${shownAd.garage}"><img src="/img/check-mark.png"></c:when>
							<c:otherwise><img src="/img/check-mark-negative.png"></c:otherwise>
						</c:choose>
					</td>
				</tr>

				<tr>
					<td><h3>Cellar</h3></td>
					<td>
						<c:choose>
							<c:when test="${shownAd.cellar}"><img src="/img/check-mark.png"></c:when>
							<c:otherwise><img src="/img/check-mark-negative.png"></c:otherwise>
						</c:choose>
					</td>
				
					<td style="padding-left:30px"><h3>Balcony</h3></td>
					<td>
						<c:choose>
							<c:when test="${shownAd.balcony}"><img src="/img/check-mark.png"></c:when>
							<c:otherwise><img src="/img/check-mark-negative.png"></c:otherwise>
						</c:choose>
					</td>
				</tr>
		
				<tr>
					<td><h3>Garden</h3></td>
					<td>
						<c:choose>
							<c:when test="${shownAd.garden}"><img src="/img/check-mark.png"></c:when>
							<c:otherwise><img src="/img/check-mark-negative.png"></c:otherwise>
						</c:choose>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<div id="msgDiv">
<form class="msgForm">
	<h2>Contact the advertiser</h2>
	<br>
	<br>
	<label>Subject: <span>*</span></label>
	<input  class="msgInput" type="text" id="msgSubject" placeholder="Subject" />
	<br><br>
	<label>Message: </label>
	<textarea id="msgTextarea" placeholder="Message" ></textarea>
	<br/>
	<button type="button" id="messageSend">Send</button>
	<button type="button" id="messageCancel">Cancel</button>
	</form>
</div>

<div id="confirmationDialog">
	<form>
	<p>Send enquiry to advertiser?</p>
	<button type="button" id="confirmationDialogSend">Send</button>
	<button type="button" id="confirmationDialogCancel">Cancel</button>
	</form>
</div>


<c:import url="template/footer.jsp" />