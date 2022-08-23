<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "t" tagdir="/WEB-INF/tags" %>

<t:base>

<div id="username-page" class="fade-in d-flex align-items-center styled-text text-white">
    <div class="container username-page-container text-center pt-5 pb-3 vh-100">
        <div class="row pt-5">
            <h3>${loggedInUser.id}, @${loggedInUser.username}, ${loggedInUser.nickname}</h3>
            
            <h4>Add Friends</h4>

            <div class="d-flex justify-content-center">
            	<div class="input-group px-4 pb-4 pt-3 w-md-75 w-lg-50">
                	<input type="text" class="form-control rounded live-search-box regular" placeholder="Search Users" aria-label="Search Users"
                   		aria-describedby="search-addon" />
                	<button type="button" class="btn btn-primary"><i class="bi bi-search"></i></button>
            	</div>
            </div>
			
			<div class="tab-form">
            	<div class="tab-header mb-4">
            		<div class="active">Your Friends</div>
            		<div>Other Users</div>
            	</div>
            	
				<div class="tab-body">
					<div class="friends active">
						<div class="d-flex justify-content-center">
							<ul class="list-group users w-100 w-md-75 w-lg-50">
							<c:forEach var="user" items="${users}">
								<c:choose>
									<c:when test="${user.id != loggedInUser.id}">
										<li class="list-group-item live-search-list rounded mb-1 mx-3 mx-sm-0">
                            				<div class="d-flex justify-content-between align-items-center">
                                				<div class="username ps-1">${user.nickname} (<small><em>@${user.username}</em></small>)</div>
                               	<c:choose>
                                    <c:when test="${loggedInUser.friendingUsers.contains(user) || loggedInUser.friendedUsers.contains(user)}">
                                        <div class="d-flex justify-content-end align-items-center gap-1">
                                            <form action="/chatrooms/private/enter" method="post" name="privateChatForm" class="chatroomSelection">
                                                <input type="hidden" name="loggedInUserId" value="${loggedInUser.id}">
                                                <input type="hidden" name="userId" value="${user.id}">
                                                <button type="submit" class="user-submit btn">Chat</button>
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
                                            <input class="user-submit btn" type="submit" value="Connect">
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                                </div>
                            </li>

                        </c:when>
                    </c:choose>
                    </c:forEach>
					</ul>	
					</div>
				</div>
				
				<div class="otherUsers">
					<div class="d-flex justify-content-center">
							<ul class="list-group users w-100 w-md-75 w-lg-50">
							<%-- <c:forEach var="user" items="${users}">
								<c:choose>
									<c:when test="${user.id != loggedInUser.id}">
										<li class="list-group-item live-search-list rounded mb-1">
                            				<div class="d-flex justify-content-between align-items-center">
                                				<div class="username ps-1">${user.nickname} (<small><em>@${user.username}</em></small>)</div>
                               	<c:choose>
                                    <c:when test="${loggedInUser.friendingUsers.contains(user) || loggedInUser.friendedUsers.contains(user)}">
                                        <div class="d-flex justify-content-end align-items-center gap-1">
                                            <form action="/chatrooms/private/enter" method="post" name="privateChatForm" class="chatroomSelection">
                                                <input type="hidden" name="loggedInUserId" value="${loggedInUser.id}">
                                                <input type="hidden" name="userId" value="${user.id}">
                                                <button type="submit" class="user-submit btn">Chat</button>
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
                                            <input class="user-submit btn" type="submit" value="Connect">
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                                </div>
                            </li>

                        </c:when>
                    </c:choose>
                    </c:forEach> --%>
					</ul>	
					</div>
				</div>
           </div>

		</div>


    
        </div>

    </div>
</div>
            

    
    
    
</t:base>