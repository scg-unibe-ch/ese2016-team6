<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<head>

<link rel="icon" href="/img/newIcon.png">
<link rel="stylesheet" type="text/css" media="screen"
	href="/css/main.css">
<link rel="stylesheet" type="text/css"
	media="only screen and (max-device-width: 480px)"
	href="/css/smartphone.css" />

<Title>HomeLender</Title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script
	src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
<link rel="stylesheet"
	href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css" />

<script src="/js/unreadMessages.js"></script>


<style>
/* ensure that autocomplete lists are not too long and have a scrollbar */
.ui-autocomplete {
	max-height: 200px;
	overflow-y: auto;
	overflow-x: hidden;
	
}
</style>



</head>




<!-- check if user is logged in -->
<security:authorize var="loggedIn" url="/profile" />

<script src="https://apis.google.com/js/platform.js" async defer></script>

<meta name="google-signin-client_id" content="181693442640-gbt2eh1lkdqkeekjura4f0oha91dndmb.apps.googleusercontent.com">


<!-- check if user has a profile picture -->

<header>
	<div class="left">
		<a href="/"><img src="/img/logo.png"></a>
		<br/>
		
		
		<!--
		<div class="left" style="color:black" style="float:left">
		<a class="headerlink" href="/about">About us</a>
		<a class="headerlink" href="/disclaimer">Disclaimer</a>
		&copy;2014 by the FlatFoundrs. All rights reserved.
		
		-->
	</div>	
		
		
	</div>
	
	
	
	<div class="right">
		<nav>
			<ul id="headerButtons">
				
				
			
				<c:choose>
					<c:when test="${loggedIn}">
					
					
					<script>
						$(document).ready(unreadMessages("header"));
					</script>
					
					<!-- include user details -->
					<%@include file='/pages/getUserPicture.jsp' %>
						<li class="HeaderButton"  id="profile_picture" >
						
						
						
						<a href="/user?id=<% out.print(realUser.getId()); %>"/>
						
						
						<% 
							out.print("<img src='" + filePath + "' />");

							if(realUser.getFirstName().equals(realUser.getLastName())) {
								out.print("<p class='text'>" + realUser.getFirstName() + "</p>"); 
							} else {
								out.print("<p class='text'>" + realUser.getFirstName() + "<br />"
									+ realUser.getLastName() + "</p>");
							}
						%>
						</a>
					
					
						
						
					
						<ul  id="ProfileDropList">
								<li class="ProfileListItem" style="top:65px;"><a href="/profile/placeAd">Place an ad</a></li>
								<li class="ProfileListItem" style="top:90px;"><a href="/profile/myRooms">My Ads</a></li>
								<li class="ProfileListItem" style="top:115px;"><% out.print("<a href=\"/ad/myAuctions?id=" + realUser.getId() + "\">My Auctions</a>"); %></li>
								<li class="ProfileListItem" style="top:140px;"><a href="/profile/myBookmarks">My Bookmarks</a></li>	
								<li class="ProfileListItem" style="top:165px;"><a href="/profile/schedule">Schedule</a></li>
								<li class="ProfileListItem" style="top:190px;"><a id="messageLink" href="/profile/messages"></a></li>
								<li class="ProfileListItem" style="top:215px;"><a id="enquiryLink" href="/profile/enquiries">Enquiries</a></li>
								<li class="ProfileListItem" style="top:240px;"><a href="/profile/alerts">Alerts</a></li>
								<li class="ProfileListItem" style="top:265px;"><a href="/logout">Logout</a></li>
						</ul>
						</li>
						
						
						<li class="headerButton"><a href="<c:url value='/searchAd' />" >Search</a></li>
					</c:when>
					
					
					<c:otherwise>
												
										<!-- 
							<form id="login-form" method="post" action="/j_spring_security_check">
									
									<li><a class="link" id="submitButton" href="<c:url value="/signup" />">Sign up</a></li>

									
									<li style=" width:auto;" >
										<button type="submit" id="submitButton" class="button">Login</button>
										</li>
									
									<li style="width:auto;padding: 5px 5px;" >
										
										<label for="field-email">Email:</label> 
										<input name="j_username" id="field-email" />
										
										<label for="field-password">Password:</label> 
										<input name="j_password" id="field-password" type="password" />
									
										
									</li>
										
										
										
										<%-- <li></li>--%>
										
										<li></li>
										
										
										
								</form>
							-->
							<button style="float:right; vertical-align: middle;" type="submit" id="modalButton">Login</button>
							<!-- <a style="float:right;margin: 20px 20px; text-align:center;" class="link" id="submitButton" href="<c:url value="/signup" />">Sign up</a> -->
							<a style="float:right;margin: 20px 0px; vertical-align: middle; text-align:center;" class="link" id="submitButton" href="<c:url value='/searchAd' />">Search</a>
							
							
					
					</c:otherwise>
				</c:choose>
				
				
			</ul>
			
			</br>
			</br>
			</br>
			
			



		</nav>
	</div>
	
	
	
	
</header>

<body>
	
	<!-- will be closed in footer-->
	<div id="content">

		
		<c:if test="${not empty confirmationMessage }">
			<div class="confirmation-message">
				<img src="/img/check-mark.png" />
				<p>${confirmationMessage }</p>
			</div>
		</c:if>
		
		