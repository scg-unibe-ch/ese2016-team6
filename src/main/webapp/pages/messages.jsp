<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="template/header.jsp" />

<!--
<pre><a href="/">Home</a>   &gt;   Messages</pre>
-->
<!-- format the dates -->
<fmt:formatDate value="${messages[0].dateSent}" var="formattedDateSent"
	type="date" pattern="HH:mm, dd.MM.yyyy" />

<script src="/js/unreadMessages.js"></script>
<script src="/js/messages.js"></script>

<script>
function deleteMessage(button) {
	var id = $(button).attr("data-id");
	$.get("/profile/messages/deleteMessage?id=" + id, function(){
		
		$("#msgDiv").load(document.URL + " #msgDiv");
	});
	location.reload();
}
</script>
<script>
	$(document).ready(function() {
		unreadMessages("messages");
		
		$("#deleteMessage").click(function(){
			var id = $(button).attr("data-id");
			$.get("/profile/messages/deleteMessage?id=" + id, function(){
				
				$("#msgDiv").load(document.URL + " #msgDiv");
			});
			location.reload();
		});	
		
		//Shows the Reply Popup
		$("#newMsg").click(function(){
			$("#content").children().animate({opacity: 0.4}, 300, function(){
				$("#messageDiv").css("display", "block");
				$("#messageDiv").css("opacity", "1");
			});
		});
		
		//Cancel Button from the Reply Popup
		$("#messageReplyCancel").click(function(){
			$("#messageDiv").css("display", "none");
			$("#messageDiv").css("opacity", "0");
			$("#content").children().animate({opacity: 1}, 300);
		});
		
		
		$("#receiverEmail").focusout(function() {
			var text = $("#receiverEmail").val();
			
			$.post("/profile/messages/validateEmail", {email:text}, function(data) {
				if (data != text) {
					alert(data);
					$("#receiverEmail").val("");
				}
			});
		});
		
		//messageForm from the Reply Popup
		$("#messageForm").submit(function (event){
			if($("#receiverEmail").val() == ""){
				event.preventDefault();
			}
		});
		
		//Send button from Reply Popup
		$("#messageReplySend").click(function() {
			if ($("#messageSubject").val() != "" && $("#messageTextarea").val() != "") {
				var subject = $("#messageSubject").val();
				var text = $("#messageTextarea").val();
				var recipientId = $("#messageRecipient").val();
				$.post("/profile/messages/sendMessageById", {
					subject : subject,
					text : text,
					recipientId : recipientId
				}, function() {
					$("#messageDiv").css("display", "none");
					$("#messageDiv").css("opacity", "0");
					$("#messageSubject").val("");
					$("#messageTextarea").val("");
					$("#content").children().animate({
						opacity : 1
					}, 300);
				})
			}
		});
	});
</script>

<h1>Messages</h1>
<hr />

<table style="align: center; padding-left: 60px;">
	<tr>
		<td valign="top" style="float:left;max-width:600px;">
		
		<div style="text-align:center;">
			<div id="folders">
				<h2 id="inbox">Inbox</h2>
				<h2 id="newMessage">New</h2>
				<h2 id="sent">Sent</h2>
			</div>
			
			</div>

			<div id="messageList" >
				<table class="styledTable" style="width:100%;">
					<tr>
						<th id="subjectColumn">Subject</th>
						<th>Sender</th>
						
						<th>Recipient</th>
						
						<th>Date sent</th>
						
						<th></th>
					</tr>
					<c:forEach items="${messages }" var="message">
						<fmt:formatDate value="${message.dateSent}"
							var="singleFormattedDateSent" type="date"
							pattern="HH:mm, dd.MM.yyyy" />

						<tr data-id="${message.id}" class="${message.state}">
							<td>${message.subject }</td>
							<td>${message.sender.email}</td>
							
							<td>${message.recipient.email}</td>
							
							<td>${singleFormattedDateSent}</td>
							
							<td><button style="background-color:#991f00;color:white" class="deleteButton" data-id="${message.id}" onClick="deleteMessage(this)">Delete</button></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</td>
		
		<td style="padding:40px;"></td>
	
		<td valign="top">
			<div id="messageList">
				<div id="messageDetail" style="width: 650px;">
					<h2>${messages[0].subject}</h2>
					<c:if test="${messages[0].isSenderNotAdmin()}">
					<button id="newMsg" type="button" style="float: right;">Reply</button>
					</c:if>
					<h3>
						<b>To: </b>${messages[0].recipient.email}
					</h3>
					<h3>
						<b>From: </b> ${messages[0].sender.email}
					</h3>
					<h3>
						<b>Date sent:</b> ${formattedDateSent}
					</h3>
					<br />
					<p>${messages[0].text }</p>
				</div>
			</div>
		</td>
	
	</tr>
</table>
<div id="messageDiv" style="display:none">
	<form class="msgForm" >
		<h2>Reply to this User</h2>
		<br> <br> <label>Subject: <span>*</span></label> 
		<input
			class="msgInput" type="text" style="display:none" id="messageRecipient" value="${messages[0].sender.id}" /><input
			class="msgInput" type="text" id="messageSubject" placeholder="Subject" />
		<br> <br> <label>Message: </label><br><br>
		<textarea rows="10" cols="43" id="messageTextarea" placeholder="Message"></textarea><br><br>
		
		<button style="background-color:#991f00;color:white" type="button" id="messageReplyCancel">Cancel</button>
		<button style="background-color:#ffffcc" type="button" id="messageReplySend">Send</button>
		
	</form>
</div>
		
<c:import url="getMessageForm.jsp" />


<c:import url="template/footer.jsp" />