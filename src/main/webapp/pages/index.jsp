<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>


<script src="https://apis.google.com/js/platform.js" async defer></script>

<meta name="google-signin-client_id" content="181693442640-gbt2eh1lkdqkeekjura4f0oha91dndmb.apps.googleusercontent.com">


<c:import url="template/header.jsp" />

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome to HomeLender</title>


</head>

<body>

<!-- imports the new login window found in template/NewLoginPop.jsp -->
<!-- This must be in the body of each page in order for the login screen to work -->
<c:import url="template/NewLoginPop.jsp" />
	

<c:choose>
	<c:when test="${empty newest}">
		<h2 style="text-align: center;"><i>No ads placed yet</i></h2>
	</c:when>
	
	<c:otherwise>
		
		<br/>
		<div id="resultsDiv" class="resultsDiv" style="margin: auto;">
			<table id="indexTable">
				<tr>
					<th>
						<h2 style="width:100%;text-align:center;">Flats for rent</h2>
					</th>
					<th>
						<h2 style="width:100%;text-align:center;">Flats for sale and/or auction</h2>
					</th>
				</tr>
				
				<tr>
					<td valign="top">
						<c:forEach var="ad" items="${newestRent}">
							
							
								<div class="resultAd">
									<table id="resultTable" style="width:100%">
										<tr>
											<th colspan="3">
												<h2>
												<a class="link" href="<c:url value='/ad?id=${ad.id}' />">${ad.title}</a>
											</h2>
											</th>
										</tr>
										<tr>
											<td>
												<div class="resultLeft">
													<a href="<c:url value='/ad?id=${ad.id}' />"><img src="${ad.pictures[0].filePath}" /></a>
												</div>
											</td>
										
											<td>
												<div class="resultMiddle">
													<p>${ad.street}, ${ad.zipcode} ${ad.city}</p>
													<p>
														<i>
														Flat with
															<c:if test="${ad.numberOfRooms==0}">  unspecified amount of  </c:if>
															<c:if test="${ad.numberOfRooms>0}"> ${ad.numberOfRooms}  </c:if>
														rooms
													</p>
												</div>
											</td>
										
											<td>
												<div class="resultRight">
													<p>
													<h2>For Rent</h2>
													</p>
													<h3>CHF ${ad.priceRent }/Month</h3> 
													
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
					</td>
			
			
					<td valign="top">
						<c:forEach var="ad" items="${newestSale}">
							
								<div class="resultAd">
									<table id="resultTable" style="width:100%">
										<tr>
											<th colspan="3">
												<h2>
												<a class="link" href="<c:url value='/ad?id=${ad.id}' />">${ad.title}</a>
												</h2>
											</th>
										</tr>
										
										<tr>
											<td>
												<div class="resultLeft">
													<a href="<c:url value='/ad?id=${ad.id}' />"><img src="${ad.pictures[0].filePath}" /></a>
												</div>
											</td>
												
											<td>
												<div class="resultMiddle">
												
													<p>${ad.street}, ${ad.zipcode} ${ad.city}</p>
													<p>
														<i>
														Flat with
															<c:if test="${ad.numberOfRooms==0}">  unspecified amount of  </c:if>
															<c:if test="${ad.numberOfRooms>0}"> ${ad.numberOfRooms}  </c:if>
														rooms
													</p>
												</div>
											</td>
										
											<td>
												<div class="resultRight">
													<p>
													<c:if test="${ad.sale=='direct'}"> <h2>For Sale</h2></c:if>
													<c:if test="${ad.sale=='auction'}"> <h2>For Auction</h2></c:if>
													<c:if test="${ad.sale=='bothAuctionAndDirect'}"> <h2>For Auction/Sale</h2></c:if>
													
													</p>
												
													<c:if test="${ad.sale=='direct'}"> <h3>CHF ${ad.priceSale } sale price </h3><br /></c:if>
													<c:if test="${ad.sale=='auction'}"> <h3>CHF ${ad.currentBid } current bid </h3><br /></c:if>
													<c:if test="${ad.sale=='bothAuctionAndDirect'}"> <h3>CHF ${ad.priceSale } sale price </h3><h3>CHF ${ad.currentBid } current Bid </h3></c:if>
													
													<br />
													<fmt:formatDate value="${ad.moveInDate}" var="formattedMoveInDate"
														type="date" pattern="dd.MM.yyyy" />
													<p>Move-in date: ${formattedMoveInDate }</p>
												</div>
											</td>
										</tr>
									</table>
								</div>
							
						</c:forEach>
					</td>
				</tr>
			</table>
		</div>
	</c:otherwise>
</c:choose>



<c:import url="template/footer.jsp" /><br />