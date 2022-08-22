<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "t" tagdir="/WEB-INF/tags" %>

<t:base>

<div id="username-page" class="fade-in d-flex align-items-center text-white">
    <div class="container username-page-container text-center pt-5 pb-3 vh-100">
        <div class="row">
            <div class="card">
                <h4 class="card-header text-primary p-4">Create a Chatroom</h4>
                <div class="card-body">
                    <form:form action="/channels/new" method="post" modelAttribute="channel">
                        <form:input type="hidden" path="creator" value="${userId}"></form:input>
                        <form:input type="hidden" path="isPublic" value="1"></form:input>
                        <div class="mb-3">
                            <form:label path="channelName" class="form-label">Channel Name </form:label>
                            <form:input path="channelName" type="text" class="form-control" placeholder="channelName" />
                            <form:errors  class="text-danger" path="channelName" />
                        </div>
                        <div class="mb-3">
                            <form:label path="channelNickname" class="form-label">Channel Nickname </form:label>
                            <form:input path="channelNickname" type="text" class="form-control" placeholder="channelNickname" />
                            <form:errors  class="text-danger" path="channelNickname" />
                        </div>
            
                        <div class="d-flex justify-content-end gap-3">
                            <input type="submit" value="Create" class="btn btn-primary">
                        </div>
                    </form:form>
            
            
                </div>
            </div>
    
            <h3>Your Chatrooms</h3>
            <form action="/chatrooms/enter" method="post" name="chatroomNameForm" class="chatroomSelection">
                <div class="row styled-text text-white mt-1">
                    <c:forEach var="channel" items="${userChannels}">
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
</div>
            

    
    
    
</t:base>