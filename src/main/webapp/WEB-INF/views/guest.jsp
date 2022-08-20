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
    <div id="username-page" class="container g-5 d-flex vh-100 justify-content-center mt-3 flex-column fade-in">
        <div class="container username-page-container text-center">
            <h1 class="styled-text text-white">Let's get started</h1>
            <form action="/guests/new" method="post" id="usernameForm" name="usernameForm" class="d-flex justify-content-center align-items-center flex-column ">
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
        </div>
    </div>

</t:base>