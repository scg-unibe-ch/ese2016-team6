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

<script src="/js/image_slider.js"></script>
<script src="/js/adDescription.js"></script>
<script src="/js/messages.js"></script>

<script>
	var shownAdvertisementID = "${ad.id}";
	var shownAdvertisement = "${ad}";
	
	$(document).ready(function() {
		
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
				var recipientEmail = "${bidService.getTopBid(ad).user.email}";
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

<script>
function deleteAd(button) {
	var id = $(button).attr("data-id");
	window.location.href = "/deleteAd?id=" + id;
}
</script>

<!-- imports the new login window found in template/NewLoginPop.jsp -->
<!-- This must be in the body of each page in order for the login screen to work -->
<c:import url="template/NewLoginPop.jsp" />
	

	<table id="indexTable" style="width:100%;text-align:center;">
				<tr>
					<th style="width:50%;">
						<h2 style="width:100%;text-align:center;">Your Auctions</h2>
					</th>
					<th style="width:50%;">
						<h2 style="width:100%;text-align:center;">Your Bids</h2>
					</th>
				</tr>	
				<tr>
				<td>	
				<c:choose>
				<c:when test="${empty myAuctions}">
					<p style="color:black;text-align:center;">You have no Ad which is sold through auction!</p>
				</c:when>
					<c:otherwise>
					<c:forEach var="ad" items="${myAuctions}">
				 	<table id="resultTable" >
						<tr>
							<th colspan="3">
								<h2>
									<a class="link" style="float:left;" href="<c:url value='/ad?id=${ad.id}' />">${ad.title }</a><button style="font-size : 12px; width:80px; height:30px; float: right; background-color:#991f00;color:white;" class="deleteButton" data-id="${ad.id}" onClick="deleteAd(this)">Delete Ad</button>
				
								</h2>
							</th>
						</tr>
						<tr>
							<td>
								<div class="resultLeftBigger">
								<fmt:formatDate value="${ad.creationDate}" var="formattedCreationDate" type="date" pattern="dd.MM.yyyy" />
								<label style="text-align: right;" id="formattedCreationDate"><b><i>Ad created on : </i>${formattedCreationDate}</b></label>
								
									<a href="<c:url value='/ad?id=${ad.id}' />"><img
									src="${ad.pictures[0].filePath}" style="width:140px; height: 120px;"/></a>
									<p>${ad.street}, ${ad.zipcode} ${ad.city}</p>
								</div>
							</td>
							
							<td>
								<div class="resultMiddle">
								<c:choose>
								<c:when test="${ad.expired=='false'}">							
								This property is for sale through auction ! 
								</br> 
									<h3><label>	Amount of the current bid : </label> CHF ${ad.currentBid}</h3>
									<h3><label>Minimum increment :</label> CHF ${ad.increment}</h3>
								</br> 
								<h3 id="timeLeft"><i>Expiry date of the auction: </i><fmt:formatDate value="${ad.expireDate}" pattern="dd.MM.yyyy HH:mm:ss"/></h3>
								</c:when>
								<c:when test="${ad.expired=='true'}">
									<h3>
									This ads auction expired on ${ad.expireDate}
									</h3>
								</c:when>
								</c:choose>
								</div>
							</td>
						
							<td>
								<div class="resultRightBigger">
									<c:if test="${bidService.getTopBid(ad).user != null}">
											<div id="bidderPresent" style="vertical-align: middle;display: inline-block;">
												<p>							
														Current highest bidder : ${bidService.getTopBid(ad).user.username}
														<br>
															<c:choose>
																<c:when test="${bidService.getTopBid(ad).user.picture.filePath != null}">
																	<img style="width:40px;height:40px;" src="${bidService.getTopBid(ad).user.picture.filePath}">
																</c:when>
																<c:otherwise>
																	<img style="width:40px;height:40px;" src="/img/avatar.png">
																</c:otherwise>
															</c:choose>
															</p>
														<h3>
															With a bid of : ${bidService.getTopBid(ad).amount} CHF
														</h3>
														<p> <br>
														This offer was made: <br>
														<fmt:formatDate value="${bidService.getTopBid(ad).timestamp}" pattern="dd.MM.yyyy HH:mm:ss"/>
														
												</p>
											</div>
											
											</c:if>
											
											<c:if test="${bidService.getTopBid(ad).user == null}">
											<h3>
												None has made a bid yet.
											</h3>
									</c:if>
								</div>
							</td>
						</tr>
					</table>
					</c:forEach>
					</c:otherwise>
				</c:choose>
			</td>
			<td>
			<c:choose>
						<c:when test="${empty myBids}">
								<p style="color:black; vertical-align:top;">You have not bidded on an ad yet!</p>
					</c:when>
					<c:otherwise>
			<c:forEach var="bid" items="${myBids}">
				<table id="resultTable" >
						<tr>
							<th colspan="3">
								<h2>
									<a class="link" style="float:left;" href="<c:url value='/ad?id=${bid.ad.id}' />">${bid.ad.title }</a><button id="newMsg" style="float:right; font-size : 12px; width:150px; height:30px;"type="button">Contact Advertiser</button>
								</h2>
							</th>
						</tr>
						<tr>
							<td>
								<div class="resultLeftBigger">
								<fmt:formatDate value="${bid.ad.creationDate}" var="formattedCreationDate" type="date" pattern="dd.MM.yyyy" />
								<label style="text-align: right;" id="formattedCreationDate"><b><i>Ad created on : </i>${formattedCreationDate}</b></label>
								
									<a href="<c:url value='/ad?id=${bid.ad.id}' />"><img
									src="${bid.ad.pictures[0].filePath}" style="width:140px; height: 120px;"/></a>
									<p>${bid.ad.street}, ${bid.ad.zipcode} ${bid.ad.city}</p>
								</div>
							</td>
							
							<td>
								<div class="resultMiddle">
								<c:choose>
								<c:when test="${bid.ad.expired=='false' && bid.ad.instantBought=='false'}">							
								This property is for sale through auction ! 
								</br> 
									<h3><label>	Amount of the current bid : </label> CHF ${bid.ad.currentBid}</h3>
									<h3><label>Minimum increment :</label> CHF ${bid.ad.increment}</h3>
								</br> 
								<h3 id="timeLeft"><i>Expiry date of the auction: </i><fmt:formatDate value="${bid.ad.expireDate}" pattern="dd.MM.yyyy HH:mm:ss"/></h3>
								</c:when>
								<c:when test="${bid.ad.expired=='true'&&bid.ad.instantBought=='false'}">
									<h3>
									This ads auction expired on ${bid.ad.expireDate}
									</h3>
								</c:when>
								
								<c:when test="${bid.ad.instantBought=='true'}">
									<h3>
									This flat has been instant bought...
									<br>
									<br>
									<c:if test="${bid.user != null}">
											<div id="bidderPresent" style="vertical-align: middle;display: inline-block;">
												<table>
													<tr>
														<td>
															...by the user : ${bid.user.username}
														</td>
														
														<td>
															<c:choose>
																<c:when test="${bid.user.picture.filePath != null}">
																	<img style="width:50px;height:50px;" src="${bid.user.picture.filePath}">
																</c:when>
																<c:otherwise>
																	<img style="width:50px; height:50px;" src="/img/avatar.png">
																</c:otherwise>
															</c:choose>
														</td>					
													</tr>	
													<tr>
														<td>
															For a sum of : ${bid.amount} CHF
														</td>
														<td>
														This offer was made: 
														<fmt:formatDate value="${bid.timestamp}" pattern="dd.MM.yyyy HH:mm:ss"/>
														</td>
													</tr>
												</table>
											</div>
											
										</c:if>
									</h3>
								</c:when>
								</c:choose>
								</div>
							</td>
						
							<td>
								<div class="resultRightBigger">
									<c:if test="${bid.user != null}">
											<div id="bidderPresent" style="vertical-align: middle;display: inline-block; float:left;">
												<p>
													Current highest bidder : ${bid.user.username}	<br>						
															<c:choose>
																<c:when test="${bid.user.picture.filePath != null}">
																	<img style="float:center;width:40px;height:40px;" src="${bid.user.picture.filePath}">
																</c:when>
																<c:otherwise>
																	<img style="float:center;width:40px;height:40px;" src="/img/avatar.png">
																</c:otherwise>
															</c:choose></p>
															<h3>
															With a bid of : ${bid.amount} CHF </h3>
														<p>
														This offer was made: <br>
														<fmt:formatDate value="${bid.timestamp}" pattern="dd.MM.yyyy HH:mm:ss"/>
												</p>
											</div>
											
											</c:if>
											
											<c:if test="${bid.user == null}">
											<h3>
												None has made a bid yet.
											</h3>
									</c:if>
								</div>
							</td>
						</tr>
				</table>
			</c:forEach>
			</c:otherwise>	
		</c:choose>
			</td>
			</tr>
			
	</table>


<div id="msgDiv">
<form class="msgForm">
	<c:if test="${countCols == 0 }">
		<c:set var="countCols" value="${1}" />
	</c:if>
	<h2>Contact the Bidder</h2>
	<br>
	<br>
	<label>Subject: <span>*</span></label>
	<input  class="msgInput" type="text" id="msgSubject" placeholder="Subject" />
	<br><br>
	<label>Message: </label>
	<textarea id="msgTextarea" placeholder="Message" ></textarea>
	<br/>
	
	<button style="background-color:#991f00;color:white" type="button" id="messageCancel">Cancel</button>
	<button style="background-color:#ffffcc" type="button" id="messageSend">Send</button>
	
	</form>
</div>

<c:import url="template/footer.jsp" />