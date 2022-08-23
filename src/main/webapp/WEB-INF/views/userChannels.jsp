<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "t" tagdir="/WEB-INF/tags" %>

<t:base>

<div id="username-page" class="fade-in d-flex align-items-center styled-text text-white">
    <div class="container username-page-container text-center pt-5 pb-3 vh-100">
        <div class="row mt-5 d-flex justify-content-center">
        		<h3 class="mb-0">Create New Room</h3>
        		<form:form action="/channels/new" method="post" modelAttribute="channel" class="p-4 w-md-75 w-lg-50">
            		<form:input type="hidden" path="creator" value="${userId}"></form:input>
                <form:input type="hidden" path="isPublic" value="1"></form:input>
           		<div class="mb-3">
                		<form:label path="channelName" class="form-label mb-1">Channel Name </form:label>
                    <form:input path="channelName" type="text" class="form-control" placeholder="channelName" autocomplete="off"/>
                    <small><form:errors  class="text-danger" path="channelName" /></small>
                </div>
                <div class="mb-3">
                    <form:label path="channelNickname" class="form-label mb-1">Channel Nickname </form:label>
                    <form:input path="channelNickname" type="text" class="form-control" placeholder="channelNickname" autocomplete="off"/>
                    <small><form:errors  class="text-danger" path="channelNickname" /></small>
                </div>
            
                <div class="d-flex justify-content-end gap-3">
                    <input type="submit" value="Create" class="user-submit btn">
                </div>
        		</form:form>
    
            <h3>Your Chatrooms</h3>
            <form action="/chatrooms/enter" method="post" name="chatroomNameForm" class="chatroomSelection">
                <div class="row styled-text text-white mt-1">
                    <c:forEach var="channel" items="${userChannels}">
                        <div class="col-sm-6 col-md-4 col-lg-3 category-selector">
                            <p>${channel.channelNickname}</p>
                            <c:choose>
								<c:when test="${channel == userChannels[0]}">
									<input type="radio" name="chatroomName" id="${channel.channelName}" value="${channel.channelNickname}" checked="checked">
								</c:when>
								<c:otherwise>
									<input type="radio" name="chatroomName" id="${channel.channelName}" value="${channel.channelName}">
								</c:otherwise>
							</c:choose>
                            <label class="category-image bg-info ${channel.channelName}" for="${channel.channelName}"></label>                       
                        </div>
                    </c:forEach>
                </div>  
                <c:if test="${userChannels.size()>0}">
                <div class="form-group fixed-bottom mb-4">
                    <button type="submit" class="username-submit styled-button btn btn-lg w-md-21 w-lg-16 w-xl-14 w-xxl-12">Let's Chat <i class="bi-arrow-right-short"></i></button>
                </div>
                </c:if>
    
            </form>
        </div>

    </div>
</div>
            

    
    
    
</t:base>