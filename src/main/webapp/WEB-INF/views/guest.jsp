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
<<<<<<< HEAD
    <div id="username-page" class="container g-5 d-flex vh-100 justify-content-center mt-3 flex-column fade-in">
        <div class="container username-page-container text-center">
            <h1 class="styled-text text-white">Let's get started</h1>
            <form action="/guests/new" method="post" id="usernameForm" name="usernameForm" class="d-flex justify-content-center align-items-center flex-column gap-2">
                <div class="form-group w-75 w-md-50 w-lg-32">
                    <input type="text" id="userId" name="userId" placeholder="Username (user id)" autocomplete="off" class="form-control" />
                </div>
                <div class="form-group w-75 w-md-50 w-lg-32">
                    <input type="text" id="userName" name="userName" placeholder="Nickname (username - public)" autocomplete="off" class="form-control" />
                </div>
                <div class="form-group">
                    <button type="submit" class="username-submit mt-2 styled-button btn btn-light btn-lg">Next <i class="bi-arrow-right-short"></i></button>
                </div>
            </form>
=======
    <div class="container g-5 d-flex vh-100 w-md-50 w-lg-32 justify-content-center mt-5 mt-sm-3 flex-column fade-in">
	<h6 class="display-6 styled-heading">Let's Get Started</h6>
	<form:form action="/guests/new" method="post" modelAttribute="newUser" class="styled-text">
		<form:input type="hidden" path="registered" value="0"></form:input>
		<div class="mb-3">
			<form:label for="username" path="username" class="form-label">Username:</form:label>
			<small><form:errors path="username" class="text-danger"/></small>
			<form:input type="text" class="form-control" path="username" />
		</div>
		<div class="mb-3">
			<form:label for="nickname" path="nickname" class="form-label">Nickname:</form:label>
			<small><form:errors path="nickname" class="text-danger"/></small>
			<form:input type="text" class="form-control" path="nickname" />
		</div>
        <div class="form-group">
            <button type="submit" class="username-submit mt-2 styled-button btn btn-light btn-lg">Next <i class="bi-arrow-right-short"></i></button>
>>>>>>> d385e6c9687a62ea5384587cfccb3cccdf4d2de8
        </div>
	</form:form>	
</div>

</t:base>