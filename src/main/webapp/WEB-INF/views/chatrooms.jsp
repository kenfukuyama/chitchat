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

    <div id="username-page" class="fade-in d-flex align-items-center text-white">
        <div class="container username-page-container text-center pt-5 pb-3 vh-100">
            <h1 class="my-5">Select your room</h1>
			<h2>Welcome ${id}, ${username}, ${nickname}</h2>

            <c:choose>
                <c:when test="${user.registered == 1}">
                    <div class="d-flex justify-content-end align-items-center gap-3 mb-3">
                        <a class="btn btn-primary" href="/users/friends">+ Add Friend</a>
                        <a class="btn btn-primary" href="/users/chatrooms">+ Create Chat Rooms</a>
                    </div>
                </c:when>
            </c:choose>

			<!-- TODO: JSP delcartion not really working, we want to check the first element -->
            <form action="/chatrooms/enter" method="post" name="chatroomNameForm" class="chatroomSelection">
                <div class="row styled-text text-white mt-1">
					<c:forEach var="channel" items="${publicChannels}">
						<div class="col-sm-6 col-md-4 col-lg-3 category-selector">
							<p>${channel.channelNickname}</p>
							<input type="radio" name="chatroomName" id="${channel.channelName}" value="${channel.channelNickname}" checked="checked">
							<label class="category-image bg-info ${channel.channelName}" for="${channel.channelName}"></label>                       
						</div>
					</c:forEach>
					
                <div class="form-group fixed-bottom mb-3">
                    <button type="submit" class="username-submit styled-button btn btn-light btn-lg w-md-21 w-lg-16 w-xl-14 w-xxl-12">Let's Chat <i class="bi-arrow-right-short"></i></button>
                </div>
    
            </form>
        </div>
    </div>
    
    
</t:base>