<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="template/header.jsp" />

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome to EstateArranger</title>
</head>

<body>

<!--<pre>Home</pre>-->

<h1>Welcome to EstateArranger!</h1>

<c:choose>
	<c:when test="${empty newest}">
		<h2>No ads placed yet</h2>
	</c:when>
	
	<c:otherwise>
		<div id="resultsDiv" class="resultsDiv">	
			<h2>Our newest ads:</h2>		
			
			
			<table style = "width=100%">
				<tr>
					<th  style="min-width: 550px">
					<h2>flats for rent</h2>
					
					</th>
					<th  style="min-width: 550px">
					<h2>flats for sale</h2>
					
					</th>
				</tr>
				
				<tr>
				<td>
				
				<c:forEach var="ad" items="${newest}">
			
				<c:if test="${ad.rent==true}">
			
				<div class="resultAd">
					<div class="resultLeft">
						<a href="<c:url value='/ad?id=${ad.id}' />"><img
							src="${ad.pictures[0].filePath}" /></a>
						<h2>
							<a class="link" href="<c:url value='/ad?id=${ad.id}' />">${ad.title}</a>
						</h2>
						<p>${ad.street}, ${ad.zipcode} ${ad.city}</p>
						<br />
						<p>
							
							
							
							
							<i>
							
								
								
								flat with
 								
 								<c:if test="${ad.numberOfRooms==0}">  unspecified amount of  </c:if>
 								<c:if test="${ad.numberOfRooms>0}"> ${ad.numberOfRooms}  </c:if>
 								
								 rooms
 							</i>
						</p>
					</div>
					<div class="resultRight">
						<h2>CHF ${ad.prizePerMonth }</h2>
						<br /> <br />

						<fmt:formatDate value="${ad.moveInDate}" var="formattedMoveInDate"
							type="date" pattern="dd.MM.yyyy" />

						<p>Move-in date: ${formattedMoveInDate }</p>
					</div>
				</div>
				
				</c:if>
			</c:forEach>
			
			</td>
			
			
			<td>
				
			<c:forEach var="ad" items="${newest}">
			
				<c:if test="${ad.rent==false}">
			
				<div class="resultAd">
					<div class="resultLeft">
						<a href="<c:url value='/ad?id=${ad.id}' />"><img
							src="${ad.pictures[0].filePath}" /></a>
						<h2>
							<a class="link" href="<c:url value='/ad?id=${ad.id}' />">${ad.title}</a>
						</h2>
						<p>${ad.street}, ${ad.zipcode} ${ad.city}</p>
						
						<br />
<<<<<<< HEAD
						<p>
							
							
							
							
							<i>
							
								
								
								flat with
 								
 								<c:if test="${ad.numberOfRooms==0}">  unspecified amount of  </c:if>
 								<c:if test="${ad.numberOfRooms>0}"> ${ad.numberOfRooms}  </c:if>
 								
								 rooms
=======

							<%-- replaced with flat
								<c:choose>
									<c:when test="${ad.studio}">Studio</c:when>
									<c:otherwise>Room</c:otherwise>
								</c:choose>
								--%>

						<p>
							<i>
								flat
 								<c:if test="${ad.numberOfRooms==0}"> with unspecified amount of rooms </c:if>
 								<c:if test="${ad.numberOfRooms>0}"> with ${ad.numberOfRooms} rooms  </c:if>
>>>>>>> origin/master
 							</i>
						</p>

					</div>
					<div class="resultRight">
						<h2>CHF ${ad.prizePerMonth }</h2>
						<br /> <br />

						<fmt:formatDate value="${ad.moveInDate}" var="formattedMoveInDate"
							type="date" pattern="dd.MM.yyyy" />

						<p>Move-in date: ${formattedMoveInDate }</p>
					</div>
				</div>
				
				</c:if>
			</c:forEach>
			
			
				
				</td>
				</tr>
			</table>
			
		</div>
	</c:otherwise>
</c:choose>

<c:import url="template/footer.jsp" /><br />