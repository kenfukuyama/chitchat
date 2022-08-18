<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "t" tagdir="/WEB-INF/tags" %>

<title>Sign Up • Chit Chat</title>
<t:base>
<div class="container d-flex vh-100 w-25 justify-content-center flex-column fade-in">
	<h6 class="display-6 styled-heading">Join the Conversation</h6>
	<form:form action="/register" method="post" modelAttribute="newUser" class="styled-text">
		<div class="mb-3">
			<form:label for="username" path="username" class="form-label">Username:</form:label>
			<form:errors path="username" class="text-danger" />
			<form:input type="text" class="form-control" path="username" />
		</div>
		<div class="mb-3">
			<form:label for="email" path="email" class="form-label">Email:</form:label>
			<form:errors path="email" class="text-danger" />
			<form:input type="text" class="form-control" path="email" />
		</div>
		<div class="mb-3">
			<form:label for="password" path="password" class="form-label">Password:</form:label>
			<form:errors path="password" class="text-danger" />
			<form:input type="password" class="form-control" path="password" />
		</div>
		<div class="mb-3">
			<form:label for="confirm" path="confirm" class="form-label">Confirm:</form:label>
			<form:errors path="confirm" class="text-danger" />
			<form:input type="password" class="form-control" path="confirm" />
		</div>
		<button type="submit" class="btn btn-light btn-lg mt-2 styled-button">Register</button>
	</form:form>	
	<p class="styled-text">Already have an account? <a href="/accounts/login">Sign In</a></p>
</div>
</t:base>
	
