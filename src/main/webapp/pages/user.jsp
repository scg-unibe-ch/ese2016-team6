<%@page import="ch.unibe.ese.team6.model.Ad"%>
<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>


<c:import url="template/header.jsp" />

<script>
	$(document).ready(function() {
		$("#newMsg").click(function() {
			$("#content").children().animate({
				opacity : 0.4
			}, 300, function() {
				$("#msgDiv").css("display", "block");
				$("#msgDiv").css("opacity", "1");
			});
		});

		$("#messageCancel").click(function() {
			$("#msgDiv").css("display", "none");
			$("#msgDiv").css("opacity", "0");
			$("#content").children().animate({
				opacity : 1
			}, 300);
		});

		$("#messageSend").click(function() {
			if ($("#msgSubject").val() != "" && $("#msgTextarea").val() != "") {
				var subject = $("#msgSubject").val();
				var text = $("#msgTextarea").val();
				var recipientEmail = "${user.username}";
				$.post("profile/messages/sendMessage", {
					subject : subject,
					text : text,
					recipientEmail : recipientEmail
				}, function() {
					$("#msgDiv").css("display", "none");
					$("#msgDiv").css("opacity", "0");
					$("#msgSubject").val("");
					$("#msgTextarea").val("");
					$("#content").children().animate({
						opacity : 1
					}, 300);
				})
			}
		});
	});
</script>

<!--
<pre>
	<a href="/">Home</a>   &gt;   Profile</pre>
-->
	
<table id="userDiv" style="float: center;">	
<tr>
<td>
<div id="userDiv" style="float: right;">
	<c:choose>
		<c:when test="${user.picture.filePath != null}">
			<img src="${user.picture.filePath}">
		</c:when>
		<c:otherwise>
			<img src="/img/avatar.png">
		</c:otherwise>
	</c:choose>
	</div>
	</td>
	<td>
	<div id="userDiv" style="float: left;">
	<p>
	<h2>Username</h2>${user.email}<p>
	<h2>Name</h2>${user.firstName}
	${user.lastName}<p>
	<h2>Kind Of Membership</h2>${user.kindOfMembership}
	<p>
	</div>
	</td>
	</tr>
	<tr>
	<td colspan="2">
	<div id="userDiv" style="float:center;">
	
	//must first check if aboutMe is not null!
	<c:if test="${user.aboutMe!=null}">
		<c:if test="${user.aboutMeNotEmpty()}">
		<hr class="slim">
		<h2>About me</h2>${user.aboutMe}
		<hr class="slim">
		</c:if>
	</c:if>
	<form>
		<c:choose>
			<c:when test="${principalID != null}">
				<c:choose>
					<c:when test="${principalID eq user.id}">
						<a class="button" href="/profile/editProfile">Edit Profile</a>
					</c:when>
					<c:otherwise>
						<button id="newMsg" type="button">Message</button>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<p>Please log in to contact this person.</p>
			</c:otherwise>
		</c:choose>
	</form>
</div>
</td>
</tr>
</table>
<div id="msgDiv">
	<form class="msgForm">
		<h2>Message this user</h2>
		<br> <br> <label>Subject: <span>*</span></label> <input
			class="msgInput" type="text" id="msgSubject" placeholder="Subject" />
		<br> <br> <label>Message: </label>
		<textarea id="msgTextarea" placeholder="Message"></textarea>
		<br />
		
		<button style="background-color:#991f00;color:white" type="button" id="messageCancel">Cancel</button>
		<button style="background-color:#ffffcc" type="button" id="messageSend">Send</button>
		
	</form>
</div>
<c:import url="template/footer.jsp" />