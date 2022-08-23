<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "t" tagdir="/WEB-INF/tags" %>

<t:base>

    <noscript>
        <h2>Sorry! Your browser doesn't support Javascript</h2>
    </noscript>
    
    <!-- enter the user page -->
    <div class="container g-5 d-flex vh-100 w-md-50 w-lg-32 justify-content-center mt-3 flex-column fade-in">
	<h6 class="display-6 styled-heading">Guest Sign In</h6>
	<form:form action="/guests/new" method="post" modelAttribute="newUser" class="styled-text">
		<form:input type="hidden" path="registered" value="0"></form:input>
		<div class="mb-3">
			<form:label for="username" path="username" class="form-label">Username:</form:label>
			<small><form:errors path="username" class="text-danger"/></small>
			<form:input type="text" class="form-control" path="username" autocomplete="off"/>
		</div>
		<div class="mb-3">
			<form:label for="nickname" path="nickname" class="form-label">Nickname:</form:label>
			<small><form:errors path="nickname" class="text-danger"/></small>
			<form:input type="text" class="form-control" path="nickname" autocomplete="off"/>
		</div>
        <div class="form-group">
            <button type="submit" class="mt-2 styled-button btn btn-light btn-lg">Next <i class="bi-arrow-right-short"></i></button>
        </div>
	</form:form>	
</div>

</t:base>