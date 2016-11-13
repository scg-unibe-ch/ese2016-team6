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

<h1 style="text-align: center;">Welcome</h1>

<c:choose>
	<c:when test="${empty newest}">
		<h2 style="text-align: center;">No ads placed yet</h2>
	</c:when>
	
	<c:otherwise>
		<h2 style="text-align: center;">Our newest ads:</h2>
		
		<div id="resultsDiv" class="resultsDiv" style="margin: auto;">	
			
			<table id="indexTable">
				<tr>
					<th>
					<h2 style="width:100%;text-align:center;">flats for rent</h2>
					
					</th>
					<th>
					<h2 style="width:100%;text-align:center;">flats for sale</h2>
					
					</th>
				</tr>
				
				<tr>
				<td valign="top">
				
			<c:forEach var="ad" items="${newest}">
			
				<%--must be changed to true--%>
				<c:if test="${ad.rent==true}">
			
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
										<a href="<c:url value='/ad?id=${ad.id}' />"><img
										src="${ad.pictures[0].filePath}" /></a>
									</div>
								</td>
							
							
							
								<td>
									<div class="resultMiddle">
						
						
									<p>${ad.street}, ${ad.zipcode} ${ad.city}</p>
						
									<p>
							
									<i>
									flat with
 								
										<c:if test="${ad.numberOfRooms==0}">  unspecified amount of  </c:if>
										<c:if test="${ad.numberOfRooms>0}"> ${ad.numberOfRooms}  </c:if>
 								
									rooms
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
				
				</c:if>
			</c:forEach>
			
			</td>
			
			
			<td valign="top">
				
			<c:forEach var="ad" items="${newest}">
			
				<c:if test="${ad.rent==false}">
			
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
										<a href="<c:url value='/ad?id=${ad.id}' />"><img
										src="${ad.pictures[0].filePath}" /></a>
									</div>
								</td>
							
							
							
								<td>
									<div class="resultMiddle">
						
						
									<p>${ad.street}, ${ad.zipcode} ${ad.city}</p>
						
									<p>
							
									<i>
									flat with
 								
										<c:if test="${ad.numberOfRooms==0}">  unspecified amount of  </c:if>
										<c:if test="${ad.numberOfRooms>0}"> ${ad.numberOfRooms}  </c:if>
 								
									rooms
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
				
				</c:if>
			</c:forEach>
			
			
				
				</td>
				</tr>
			</table>
			
		</div>
	</c:otherwise>
</c:choose>

<c:import url="template/footer.jsp" /><br />