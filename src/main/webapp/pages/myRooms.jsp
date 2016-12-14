%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<c:import url="template/header.jsp" />

<script>
	$(document).ready(function() {
	});

</script>

<!--
<pre><a href="/">Home</a>   &gt;   My advertisements</pre>
-->

		<table id="indexTable" style="width:100%;text-align:left; padding: 30px;">
			<tr>
				<th>
					<h2 style="width:100%;text-align:center;">My Ads</h2>
				</th>
			</tr>
			<tr>
			<td valign="top">
			<c:choose>
			<c:when test="${empty ownAdvertisements}">
				
				<p style="color:black;text-align:center;">You have not advertised anything yet.</p>
				
			</c:when>
			
			<c:otherwise>
				
				<div id="resultsDiv"  class="resultsDiv" style="width: 100%;">
				
				
						
					<c:forEach var="ad" items="${ownAdvertisements}">
						<div class="resultAd" data-price="${ad.getPriceAll()}" 
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
											<p>${ad.street}, ${ad.zipcode} ${ad.city}</p>
								
											<p>
												<i>
										
										
													flat
										
													<c:if test="${ad.numberOfRooms==0}"> with unspecified amount of rooms </c:if>
													<c:if test="${ad.numberOfRooms>0}"> with ${ad.numberOfRooms} rooms  </c:if>
										
												</i>
											</p>
										</div>
									</td>
								
									<td>
										<div class="resultRight">
										<p>
											<c:if test="${ad.deal=='forRent'}"> <h2>For Rent</h2></c:if>
											<c:if test="${ad.deal=='forSale'}">
												<c:if test="${ad.sale=='direct'}"> <h2>For Sale</h2></c:if>
												<c:if test="${ad.sale=='auction'}"> <h2>For Auction</h2></c:if>
												<c:if test="${ad.sale=='bothAuctionAndDirect'}"> <h2>For Auction/Sale</h2></c:if>
											</c:if>
											</p>
										
											<c:if test="${ad.deal=='forRent'}"> <h3>CHF ${ad.priceRent}/Month</h3></br></c:if>
											<c:if test="${ad.deal=='forSale'}">
													<c:if test="${ad.sale=='direct'}"> <h3>CHF ${ad.priceSale} sale price </h3><br /></c:if>
													<c:if test="${ad.sale=='auction'}"> <h3>CHF ${ad.currentBid} current bid </h3><br /></c:if>
													<c:if test="${ad.sale=='bothAuctionAndDirect'}"> <h3>CHF ${ad.priceSale} sale price </h3> <h3>CHF ${ad.currentBid } current Bid </h3></c:if>
											</c:if>
								

											<fmt:formatDate value="${ad.moveInDate}" var="formattedMoveInDate"
														type="date" pattern="dd.MM.yyyy" />
													<p>Move-in date: ${formattedMoveInDate }</p>
										</div>
							
									</td>
								</tr>
							</table>
								
							
						</div>
					</c:forEach>
					<br /> <br />
					</div>
			</c:otherwise>
		</c:choose>
		</td>
		

		</tr>
		</table>
		
		

<c:import url="template/footer.jsp" />