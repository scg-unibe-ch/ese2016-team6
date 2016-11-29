<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

<!-- check if user is logged in -->
<security:authorize var="loggedIn" url="/profile" />

<script src="https://apis.google.com/js/platform.js" async defer></script>

<meta name="google-signin-client_id" content="181693442640-gbt2eh1lkdqkeekjura4f0oha91dndmb.apps.googleusercontent.com">


<c:import url="template/header.jsp" />


<h1 style="text-align:center">Login</h1>

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
		<p>You are already logged in!</p>
	</c:when>
	<c:otherwise>
		<c:if test="${!empty param.error}">
			<p>Incorrect email or password. Please retry using correct email
				and password.</p>
			<br />
		</c:if>
		 <div class="modal-body" style="text-align:center">
		
		<form style="margin:auto" id="login-form" method="post" action="/j_spring_security_check">
			<label for="field-email">Email:</label> <input name="j_username"
				id="field-email" /> <label for="field-password">Password:</label> <input
				name="j_password" id="field-password" type="password" />
			<button type="submit">Login</button>
		</form>
		<br>
		<br>
		Or <a class="button"  href="<c:url value="/signup" />">Sign up</a> as a new user.
		<br>
		<br>
		
		or use Google to login 
			<div style="display:inline-block; vertical-align: middle;" class="g-signin2" data-onsuccess="onSignIn"></div>
			

		<br>
		<br>
		or use Facebook to login 
		<a style="display:inline-block; vertical-align: middle;" href="https://www.facebook.com/dialog/oauth?client_id=983560241788003&redirect_uri=http://localhost:8080/facebooklogin&scope=email"><img src="img/FB-Logo.png" /></a>
		</c:otherwise>
		</c:choose>

		
		<br />
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

	<div>
		<form:form id="googleForm" type="hidden" class="form-horizontal" method="post"
			modelAttribute="googleForm" action="./googlelogin">

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


		
<c:import url="template/footer.jsp" />