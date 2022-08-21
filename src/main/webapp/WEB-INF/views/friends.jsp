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
            <h4>${loggedInUser.id}, @${loggedInUser.username}, ${loggedInUser.nickname}</h4>
            
            <h5>Add Friends</h5>
            <div class="input-group mb-3">
                <input type="search" class="form-control rounded" placeholder="Search" aria-label="Search"
                    aria-describedby="search-addon" />
                <button type="button" class="btn btn-outline-primary">search</button>
            </div>

            <ul class="list-group">
                <c:forEach var="user" items="${users}">
                    <c:choose>
                        <c:when test="${user.id != loggedInUser.id}">
                            <li class="list-group-item d-flex justify-content-between align-items-center gap-3">
                                <div class="username">${user.nickname} (<small><em>@${user.username}</em></small>)</div>
                                <c:choose>
                                    <c:when test="${loggedInUser.friendingUsers.contains(user) || loggedInUser.friendedUsers.contains(user)}">
                                        <div class="d-flex justify-content-end align-items-center gap-3">
                                            <form action="/chatrooms/private/enter" method="post" name="privateChatForm" class="chatroomSelection">
                                                <input type="hidden" name="loggedInUserId" value="${loggedInUser.id}">
                                                <input type="hidden" name="userId" value="${user.id}">
                                                <button type="submit" class="btn btn-primary">Chat</button>
                                            </form>
                                            <form action="/users/removeConnect" method="post">
                                                <input type="hidden" name="loggedInUserId" value="${loggedInUser.id}">
                                                <input type="hidden" name="userId" value="${user.id}">
                                                <input class="btn btn-secondary" type="submit" value="Undo">
                                            </form>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <form action="/users/addConnect" method="post">
                                            <input type="hidden" name="loggedInUserId" value="${loggedInUser.id}">
                                            <input type="hidden" name="userId" value="${user.id}">
                                            <input class="btn btn-primary" type="submit" value="Connect">
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </li>

                        </c:when>
                    </c:choose>
                    
                </c:forEach>
            </ul>




    
        

    </div>
</div>
            

    
    
    
</t:base>