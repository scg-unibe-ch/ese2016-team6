<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<c:import url="template/header.jsp" />

<script>
	$(document).ready(function() {
	});

</script>


<pre><a href="/">Home</a>   &gt;   My properties</pre>


		<table id="indexTable">
			<tr>

			<tr>
				<th>
					<h2 style="width:100%;text-align:center;">My Advertisements</h2>
				</th>
				<th>
					<h2 style="width:100%;text-align:center;">My Bookmarks</h2>
				</th>
			</tr>
			
			<td valign="top">
			<c:choose>
			<c:when test="${empty ownAdvertisements}">
				
				<p style="color:black;text-align:center;">You have not advertised anything yet.</p>
				
			</c:when>
			
			<c:otherwise>
				
				<div id="resultsDiv"  class="resultsDiv" style="width: 100%;">
				
				
						
					<c:forEach var="ad" items="${ownAdvertisements}">
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
											</br>
											<p>
											For
											<c:if test="${ad.rent=true}"> rent </c:if>
											<c:if test="${ad.rent=false}"> sale </c:if>
											</p>
								
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
											<h2>CHF ${ad.prizePerMonth }</h2>
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
					<br /> <br />
					</div>
			</c:otherwise>
		</c:choose>
		</td>
		
		<td valign="top">
		<c:choose>
			<c:when test="${empty bookmarkedAdvertisements}">
				
				
				<p style="color:black;text-align:center;">You have not bookmarked anything yet.</p><br /><br />
			</c:when>
			<c:otherwise>
				
				<div id="resultsDiv" style="width: 100%;" class="resultsDiv">
				
							
					<c:forEach var="ad" items="${bookmarkedAdvertisements}">
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
											</br>
											<p>
											For
											<c:if test="${ad.rent=true}"> rent </c:if>
											<c:if test="${ad.rent=false}"> sale </c:if>
											</p>
								
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
											<h2>CHF ${ad.prizePerMonth }</h2>
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