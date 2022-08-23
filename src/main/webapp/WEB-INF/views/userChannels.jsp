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
               	<div class="d-flex justify-content-between">
               		<div class="d-flex align-items-start">
               			<form:input type="hidden" path="isPublic" value="1"></form:input>
               			<div class="form-check form-switch">
               				<input type="hidden" name="privacySwitch">
  							<input class="form-check-input" type="checkbox" name="privacySwitch" value="0" id="flexSwitchCheckChecked" checked>
  							<label class="form-check-label" for="flexSwitchCheckChecked">Private</label>
						</div>
                		
           			</div>
           			 <div class="d-flex justify-content-end gap-3">
                    	<input type="submit" value="Create" class="user-submit btn">
                	</div>
           			
            	</div>
               
        		</form:form>
    
            <h3>Your Chatrooms</h3>
            
            <div class="d-flex justify-content-center">
            	<div class="input-group px-4 pb-4 pt-3 w-md-75 w-lg-50">
                	<input type="text" class="form-control rounded live-search-box regular" placeholder="Search Channels" aria-label="Search Channels"
                   		aria-describedby="search-addon" />
                	<button type="button" class="btn btn-primary"><i class="bi bi-search"></i></button>
            	</div>
            </div>
            
            <div class="tab-form">
            	<div class="tab-header mb-4">
            		<div class="active">Public</div>
            		<div>Private</div>
            	</div>
            
            	<div class="tab-body">
					<div class="publicRoom active">
						<form action="/chatrooms/enter" method="post" name="chatroomNameForm" class="chatroomSelection">
                		<div class="row styled-text text-white mt-1">
                    		<c:forEach var="channel" items="${userChannels}">
                        		<div class="col-sm-6 col-md-4 col-lg-3 category-selector live-search-list">
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
				
				<div class="privateRoom">
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
            

    
    
    
</t:base>