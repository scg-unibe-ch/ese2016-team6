<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:import url="template/header.jsp" />

<script>
	// Validate the email field
	$(document).ready(function() {
		$("#field-email").focusout(function() {
			var text = $(this).val();
			$.post("/signup/doesEmailExist", {email: text}, function(data){
				if(data){
					alert("This username is taken. Please choose another one!");
					$("#field-email").val("");
				}
			});
		});
	});
</script>
<script>
function validateType(form) {
	$("#field-email").focusout(function() {
		var text = $(this).val();
		$.post("/signup/doesEmailExist", {email: text}, function(data){
			isValid = data;
		});
	});
});
</script>

<pre>
	<a href="/">Home</a>   &gt;   Sign up</pre>

<h1>Sign up</h1>
<form:form id="signupForm" method="post" modelAttribute="signupForm"
	action="signup">
	<fieldset>
		<legend>Enter Your Information</legend>

		<table>

			<tr>
				<td class="signupDescription"><label for="field-firstName">First Name:</label></td>
				<td><form:input path="firstName" cssClass="form-control" id="field-firstName" /> <form:errors
						path="firstName" cssClass="validationErrorText" /></td>
			</tr>

			<tr>
				<td class="signupDescription"><label for="field-lastName">Last Name:</label></td>
				<td><form:input path="lastName" cssClass="form-control" id="field-lastName" /> 
				<form:errors path="lastName" cssClass="validationErrorText" /></td>
			</tr>

			<tr>
				<td class="signupDescription"><label for="field-password">Password:</label></td>
				<td><form:input path="password" cssClass="form-control" id="field-password"
						type="password" /> <form:errors path="password"
						cssClass="validationErrorText" /></td>
			</tr>

			<tr>
				<td class="signupDescription"><label for="field-email">Email:</label></td>
				<td><form:input path="email" cssClass="form-control" id="field-email"/> 
				<form:errors path="email" cssClass="validationErrorText" /></td>
				
				<form:checkbox id="isValid" style="display:none" name="isValid" path="isValid" readonly="readonly"/>
				<form:errors path="isValid" cssClass="validationErrorText" />
			</tr>

			<tr>
				<td class="signupDescription"><label for="field-gender">Gender:</label></td>
				<td><form:select path="gender" class="form-control">
						<form:option value="FEMALE" label="Female" />
						<form:option value="MALE" label="Male" />
					</form:select></td>
			</tr>
			<tr>
				<td class="signupDescription"><label for="field-kind">Kind of Membership:</label></td>
				<td><form:select path="KindOfMembership" class="form-control">
						<form:option value="NORMAL" label="Normal" />
						<form:option value="PREMIUM" label="Premium" />
					</form:select></td>
			</tr>
		</table>
		<br />
		<b>For a premium Membership you have to pay!</b>
		<br />
		<br />
		<button type="submit" onClick="validateType(this.form)">Sign up</button>
	</fieldset>
</form:form>

<c:import url="template/footer.jsp" />