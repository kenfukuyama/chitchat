<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "t" tagdir="/WEB-INF/tags" %>

<title>Sign In • Chit Chat</title>
<t:base>
<div class="container g-5 d-flex vh-100 w-md-60 w-lg-40 justify-content-center flex-column fade-in">
	<h6 class="display-6 styled-heading">Sign In</h6>

	<form:form action="/login" method="post" modelAttribute="newLogin" class="styled-text">
		<div class="mb-3">
			<form:label for="email" path="email" class="form-label">Email:</form:label>
			<small><form:errors path="email" class="text-danger" /></small>
			<form:input type="text" path="email" class="form-control" />
		</div>
		<div class="mb-3">
			<form:label for="password" path="password" class="form-label">Password:</form:label>
			<small><form:errors path="password" class="text-danger" /></small>
			<form:input type="password" path="password" class="form-control" />
		</div>
		<button type="submit" class="btn btn-light btn-lg mt-2 styled-button">Sign In</button>
	</form:form>
	<p class="styled-text">Don't have an account? <a href="/accounts/register">Sign Up</a></p>
</div>
</t:base>
	