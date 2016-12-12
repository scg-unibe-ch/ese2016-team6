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
		
		var minBid = ${ad.currentBid} + ${ad.increment};
		
		document.getElementById('bidAmount').min = minBid;
		document.getElementById('bidAmount').value = minBid;
		
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
				var recipientEmail = "${latestBid.user.email}";
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
	$.post("/deleteAd?id=" + id);
	window.location.href = "/deletedAd";
}
</script>


 <script>
        function showTimeLeft() {
            //We need getTime() to make the countdown compatible with all browsers.
            var expired = ${shownAd.expireDate.getTime()};
            var current = new Date();

           <%-- if (current > expired || ${shownAd.expired}) {
                $('#bidInfo').html("<h2>We are sorry but this auction is over!</h2>");
            } else {--%>
                var msec = expired - current;

                var dd = Math.floor(msec / 1000 / 60 / 60 / 24);

                msec -= dd * 1000 * 60 * 60 * 24;
                var hh = Math.floor(msec / 1000 / 60 / 60);
                msec -= hh * 1000 * 60 * 60;
                var mm = Math.floor(msec / 1000 / 60);
                msec -= mm * 1000 * 60;
                var ss = Math.floor(msec / 1000);
                msec -= ss * 1000;
                if (dd > 0) {
                    $('#timeLeft').html("Time Left: " + dd + " Days, " + hh + " Hours, " + mm + " Minutes, " + ss + " Seconds");
                }
                else {
                    if (hh > 0) {
                        $('#timeLeft').html("Time Left: " + hh + " Hours, " + mm + " Minutes, " + ss + " Seconds");
                    }
                    else {
                        if (mm > 0) {
                            $('#timeLeft').html("Time Left: " + +mm + " Minutes, " + ss + " Seconds");
                        }
                        else {
                            $('#timeLeft').html("Time Left: " + ss + " Seconds");
                        }
                    }
                }

        }

        var timer = setInterval(showTimeLeft, 1000);
    </script>

<!-- imports the new login window found in template/NewLoginPop.jsp -->
<!-- This must be in the body of each page in order for the login screen to work -->
<c:import url="template/NewLoginPop.jsp" />
	

<div id="resultsDiv" class="resultsDiv" style="float:left; align:center; width:100%;">	
	<table id="indexTable">
				<tr>
					<th>
						<h2 style="width:100%;text-align:center;">Your auctions</h2>
					</th>
					<th>
						<h2 style="width:100%;text-align:center;">Your bids</h2>
					</th>
				</tr>	
				<tr>
				<td>	
					<c:forEach var="ad" items="${myAuctions}">
				
								
				 	<table id="resultTable" >
						<tr>
							<th colspan="3">
								<h2>
									<a class="link" style="float:left;" href="<c:url value='/ad?id=${ad.id}' />">${ad.title }</a><button style="font-size : 12px; width:80px; height:30px; float: right; background-color:#991f00;color:white;" class="deleteButton" data-id="${ad.id}" onClick="deleteAd(this)" href="/deletedAd">Delete Ad</button>
				
								</h2>
							</th>
						</tr>
						<tr>
							<td>
								<div class="resultLeftBigger">
								<fmt:formatDate value="${ad.creationDate}" var="formattedCreationDate" type="date" pattern="dd.MM.yyyy" />
								<label style="text-align: right;" id="formattedCreationDate"><b><i>Ad created on : </i>${formattedCreationDate}</b></label>
								
									<a href="<c:url value='/ad?id=${ad.id}' />"><img
									src="${ad.pictures[0].filePath}" /></a>
									<p>${ad.street}, ${ad.zipcode} ${ad.city}</p>
								</div>
							</td>
							
							<td>
								<div class="resultMiddle">
								<c:choose>
								<c:when test="${ad.expired=='false' && ad.instantBought=='false'}">							
								This property is for sale through auction ! 
								</br> 
									<h3><label>	Amount of the current bid : </label> CHF ${ad.currentBid}</h3>
									<h3><label>Minimum increment :</label> CHF ${ad.increment}</h3>
								</br> 
								<h3 id="timeLeft"><i>Expiry date of the auction: </i><fmt:formatDate value="${ad.expireDate}" pattern="dd.MM.yyyy HH:mm:ss"/></h3>
								</c:when>
								<c:when test="${ad.expired=='true'&&ad.instantBought=='false'}">
									<h3>
									This ads auction expired on ${ad.expireDate}
									</h3>
								</c:when>
								
								<c:when test="${ad.instantBought=='true'}">
									<h3>
									This flat has been instant bought...
									<br>
									<br>
									<c:if test="${latestBid.user != null}">
											<div id="bidderPresent" style="vertical-align: middle;display: inline-block;">
												<table>
													<tr>
														<td>
															...by the user : ${latestBid.user.username}
														</td>
														
														<td>
															<c:choose>
																<c:when test="${latestBid.user.picture.filePath != null}">
																	<img style="width:50px;height:50px;" src="${latestBid.user.picture.filePath}">
																</c:when>
																<c:otherwise>
																	<img src="/img/avatar.png">
																</c:otherwise>
															</c:choose>
														</td>					
													</tr>	
													<tr>
														<td>
															For a sum of : ${latestBid.amount} CHF
														</td>
														<td>
														This offer was made: 
														<fmt:formatDate value="${latestBid.timestamp}" pattern="dd.MM.yyyy HH:mm:ss"/>
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
									<c:if test="${latestBid.user != null}">
											<div id="bidderPresent" style="vertical-align: middle;display: inline-block;">
												<h3>							
												<table>
													<tr>
														<td>
															Current highest bidder : ${latestBid.user.username}
														</td>
														
														<td>
															<c:choose>
																<c:when test="${latestBid.user.picture.filePath != null}">
																	<img style="width:40px;height:40px;" src="${latestBid.user.picture.filePath}">
																</c:when>
																<c:otherwise>
																	<img style="width:40px;height:40px;" src="/img/avatar.png">
																</c:otherwise>
															</c:choose>
														</td>							
													</tr>	
													<tr>
														<td>
															With a bid of : ${latestBid.amount} CHF
														</td>
														<td>
														This offer was made: 
														<fmt:formatDate value="${latestBid.timestamp}" pattern="dd.MM.yyyy HH:mm:ss"/>
														</td>
													</tr>
												</table>
												</h3>
											</div>
											
											</c:if>
											
											<c:if test="${latestBid.user == null}">
											<h3>
												None has made a bid yet.
											</h3>
									</c:if>
								</div>
							</td>
						</tr>
					</table>
			</c:forEach>
			</td>
			<td>
			<c:forEach var="ad" items="${myBids}">
				
					<!-- 			
				 	<table id="resultTable" >
						<tr>
							<th colspan="3">
								<h2>
									<a class="link" style="float:left;" href="<c:url value='/ad?id=${ad.id}' />">${ad.title }</a><button style="font-size : 12px; width:80px; height:30px; float: right; background-color:#991f00;color:white;" class="deleteButton" data-id="${ad.id}" onClick="deleteAd(this)" href="/deletedAd">Delete Ad</button>
				
								</h2>
							</th>
						</tr>
						<tr>
							<td>
								<div class="resultLeftBigger">
								<fmt:formatDate value="${ad.creationDate}" var="formattedCreationDate" type="date" pattern="dd.MM.yyyy" />
								<label style="text-align: right;" id="formattedCreationDate"><b><i>Ad created on : </i>${formattedCreationDate}</b></label>
								
									<a href="<c:url value='/ad?id=${ad.id}' />"><img
									src="${ad.pictures[0].filePath}" /></a>
									<p>${ad.street}, ${ad.zipcode} ${ad.city}</p>
								</div>
							</td>
							
							<td>
								<div class="resultMiddle">
								<c:choose>
								<c:when test="${ad.expired=='false' && ad.instantBought=='false'}">							
								This property is for sale through auction ! 
								</br> 
									<h3><label>	Amount of the current bid : </label> CHF ${ad.currentBid}</h3>
									<h3><label>Minimum increment :</label> CHF ${ad.increment}</h3>
								</br> 
								<h3 id="timeLeft"><i>Expiry date of the auction: </i><fmt:formatDate value="${ad.expireDate}" pattern="dd.MM.yyyy HH:mm:ss"/></h3>
								</c:when>
								<c:when test="${ad.expired=='true'&&ad.instantBought=='false'}">
									<h3>
									This ads auction expired on ${ad.expireDate}
									</h3>
								</c:when>
								
								<c:when test="${ad.instantBought=='true'}">
									<h3>
									This flat has been instant bought...
									<br>
									<br>
									<c:if test="${latestBid.user != null}">
											<div id="bidderPresent" style="vertical-align: middle;display: inline-block;">
												<table>
													<tr>
														<td>
															...by the user : ${latestBid.user.username}
														</td>
														
														<td>
															<c:choose>
																<c:when test="${latestBid.user.picture.filePath != null}">
																	<img style="width:50px;height:50px;" src="${latestBid.user.picture.filePath}">
																</c:when>
																<c:otherwise>
																	<img src="/img/avatar.png">
																</c:otherwise>
															</c:choose>
														</td>					
													</tr>	
													<tr>
														<td>
															For a sum of : ${latestBid.amount} CHF
														</td>
														<td>
														This offer was made: 
														<fmt:formatDate value="${latestBid.timestamp}" pattern="dd.MM.yyyy HH:mm:ss"/>
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
									<c:if test="${latestBid.user != null}">
											<div id="bidderPresent" style="vertical-align: middle;display: inline-block;">
												<h3>							
												<table>
													<tr>
														<td>
															Current highest bidder : ${latestBid.user.username}
														</td>
														
														<td>
															<c:choose>
																<c:when test="${latestBid.user.picture.filePath != null}">
																	<img style="width:40px;height:40px;" src="${latestBid.user.picture.filePath}">
																</c:when>
																<c:otherwise>
																	<img style="width:40px;height:40px;" src="/img/avatar.png">
																</c:otherwise>
															</c:choose>
														</td>							
													</tr>	
													<tr>
														<td>
															With a bid of : ${latestBid.amount} CHF
														</td>
														<td>
														This offer was made: 
														<fmt:formatDate value="${latestBid.timestamp}" pattern="dd.MM.yyyy HH:mm:ss"/>
														</td>
													</tr>
												</table>
												</h3>
											</div>
											
											</c:if>
											
											<c:if test="${latestBid.user == null}">
											<h3>
												None has made a bid yet.
											</h3>
									</c:if>
								</div>
							</td>
						</tr>
					</table>
			</c:forEach> -->
			</td>
			</tr>
			
	</table>
</div>

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