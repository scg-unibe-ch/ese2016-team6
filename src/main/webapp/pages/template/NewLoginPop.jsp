<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>



<meta name="google-signin-client_id" content="181693442640-gbt2eh1lkdqkeekjura4f0oha91dndmb.apps.googleusercontent.com">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css" />

<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

<security:authorize var="loggedIn" url="/profile" />
	
<div style="display:none">
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script
	src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
	
	<script src="/js/unreadMessages.js"></script>
</div>
	

<!-- The Modal -->
<div id="myModal" class="modal">


  
  <div class="modal-content">
    <div class="modal-header">
      <span class="close">×</span>
      <h2>Login Form</h2>
    </div>
    <div class="modal-body">
		<!-- Modal content -->
		
		<div id="fb-root"></div>
		<script>(function(d, s, id) {
		  var js, fjs = d.getElementsByTagName(s)[0];
		  if (d.getElementById(id)) return;
		  js = d.createElement(s); js.id = id;
		  js.src = "//connect.facebook.net/de_DE/sdk.js#xfbml=1&version=v2.8";
		  fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));</script>
	
	
	
	<c:choose>
		<c:when test="${loggedIn}">
			<p> <h3 style="color:red"> You are already logged in! </h3> </p>
		</c:when>
		<c:otherwise>
			<c:if test="${!empty param.error}">
				<p><h3 style="color:red">Incorrect email or password. Please retry using correct email
					and password.</h3></p>
				<br />
			</c:if>
			<form id="login-form" method="post" action="/j_spring_security_check">
				<label for="field-email">Email:</label> <input name="j_username"
					id="field-email" /> <label for="field-password">Password:</label> <input
					name="j_password" id="field-password" type="password" />
				<button type="submit">Login</button>
			</form>
			<br>
			<br>
			Or <a class="button"  href="<c:url value="/signup" />" >sign up</a> as a new user.
			<br>
			
			<br>
			<br>
			
			or use google to sign in
				<div style="display:inline-block; vertical-align: middle;" class="g-signin2" data-onsuccess="onSignIn">	</div>
				

			<br>
			<br>
			or use facebook to sign in
			<a style="display:inline-block; vertical-align: middle;" href="https://www.facebook.com/dialog/oauth?client_id=983560241788003&redirect_uri=http://localhost:8080/facebooklogin&scope=email"><img src="img/FB-Logo.png" /></a>
			
		</c:otherwise>
	</c:choose>
	<br>
	<br>
	<br />
		
	
	<br />
		<h2>Test users</h2>
		<br />
		<ul class="test-users">
			<li>Email: <i>ese@unibe.ch</i>, password: <i>ese</i></li>
			<li>Email: <i>jane@doe.com</i>, password: <i>password</i></li>
			<li>Email: <i>user@bern.com</i>, password: <i>password</i></li>
			<li>Email: <i>oprah@winfrey.com</i>, password: <i>password</i></li>
		</ul>
	<br />		
		
    </div>
    <div class="modal-footer">
     
    </div>
  </div>

</div>

<div>
			<form:form id="googleForm" type="hidden" class="form-horizontal" method="post"
				modelAttribute="googleSignupForm" action="./googlelogin">

					<spring:bind path="firstName">
								<form:input type="hidden" path="firstName" cssClass="form-control"
									id="field-firstName" />
					</spring:bind>

					<spring:bind path="lastName">
								<form:input type="hidden" path="lastName" id="field-lastName"
									cssClass="form-control" />
					</spring:bind>

					<spring:bind path="email">	
								<form:input type="hidden" path="email" id="field-mail"
									cssClass="form-control" />
					</spring:bind>
					
					<spring:bind path="googlePicture">	
								<form:input type="hidden" path="googlePicture" id="field-googlePicture"
									cssClass="form-control" />					
					</spring:bind>
					
				<button type="submit" style="visibility:hidden;" class="btn btn-primary" value="signup" id="googleButton"
						>Sign up</button>
						
				</form:form>
		</div>
	 
	
	<script>
	function onSignIn(googleUser) {
	 	var profile = googleUser.getBasicProfile();
		$("#field-firstName").val(profile.getGivenName());
		$("#field-lastName").val(profile.getFamilyName());
		$("#field-mail").val(profile.getEmail());
		$("#field-googlePicture").val(profile.getImageUrl());
		var auth2 = gapi.auth2.getAuthInstance();
    	auth2.signOut();
		$("#googleButton").click();
		
	}
	</script>

		

<script>
window.onload = function(){
	// Get the modal
	var modal = document.getElementById('myModal');
	// Get the button that opens the modal
	var btn = document.getElementById("modalButton");
	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];
	// When the user clicks the button, open the modal 
	btn.onclick = function() {
		modal.style.display = "block";
		
		modal.style.animation = "animatetop 0.4s";
		modal.style.opacity = 1;
		modal.style.top="0px";
		
	}
	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
		
		
		modal.style.animation = "animatebot 0.4s";
		modal.style.opacity = 0;
		
		
		setTimeout(function(){
			modal.style.display = "none";
			}
			,300
			);
	}
	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
		if (event.target == modal) {
			//modal.style.display = "none";
			modal.style.opacity = 0;
			modal.style.animation = "animatebot 0.4s";
			
			
			setTimeout(function(){
			modal.style.display = "none";
			}
			,300
			);
		}
	}
}
</script>


<c:if test="${!empty param.error}">

<script>
	window.onload = function(){
		
		// Get the modal
		var modal = document.getElementById('myModal');
		
		
		// if the login failed the modal is repositioned to be visible after page load
		modal.style.display = "block";
		
		modal.style.animation = "animatebot 0s 0s";
		modal.style.opacity = 1;
		modal.style.top="0px";
		
		// Get the modal
		var modal = document.getElementById('myModal');
		// Get the button that opens the modal
		var btn = document.getElementById("modalButton");
		// Get the <span> element that closes the modal
		var span = document.getElementsByClassName("close")[0];
		// When the user clicks the button, open the modal 
		btn.onclick = function() {
			modal.style.display = "block";
			
			modal.style.animation = "animatetop 0.4s";
			modal.style.opacity = 1;
			modal.style.top="0px";
			
		}
		// When the user clicks on <span> (x), close the modal
		span.onclick = function() {
			
			
			modal.style.animation = "animatebot 0.4s";
			modal.style.opacity = 0;
			
			
			setTimeout(function(){
				modal.style.display = "none";
				}
				,300
				);
		}
		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
			if (event.target == modal) {
				//modal.style.display = "none";
				modal.style.opacity = 0;
				modal.style.animation = "animatebot 0.4s";
				
				
				setTimeout(function(){
				modal.style.display = "none";
				}
				,300
				);
			}
		}
		
		
	}
</script>
</c:if>




