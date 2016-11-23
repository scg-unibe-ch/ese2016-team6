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

<script src="https://www.facebook.com/connect/login_success.html" async defer></script>


<c:import url="template/header.jsp" />

<pre>
	<a href="/">Home</a>   &gt;   Login</pre>

<h1>Login</h1>

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
		<form id="login-form" method="post" action="/j_spring_security_check">
			<label for="field-email">Email:</label> <input name="j_username"
				id="field-email" /> <label for="field-password">Password:</label> <input
				name="j_password" id="field-password" type="password" />
			<button type="submit">Login</button>
		</form>
		Or <a class="button"  href="<c:url value="/signup" />">sign up</a> as a new user.
		<br>
		
		<p>
			Or login with your Google account: <div class="g-signin2" data-onsuccess="onSignIn"></div>
						</c:otherwise>
					</c:choose>
		
		
		<br />
		<h2>Test users</h2>

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


		
<c:import url="template/footer.jsp" />