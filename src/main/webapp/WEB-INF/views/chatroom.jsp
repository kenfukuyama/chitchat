<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "t" tagdir="/WEB-INF/tags" %>

<t:base>
    <script defer type="text/javascript" src="/js/chat.js"></script>

    <noscript>
        <h2>Sorry! Your browser doesn't support Javascript</h2>
    </noscript>

	<span id="username" class="d-none">${username}</span>
	<span id="nickname" class="d-none">${nickname}</span>

	<span class="d-none" id="userId">${id}</span>
	<span class="d-none" id="channelId">${channelId}</span>
	
    <div id="chat-page" class="fade-in d-flex align-items-end justify-content-center vh-100 w-100 styled-text text-white">
        <div class="chat-container w-100 w-sm-75 w-lg-62 w-xxl-50">
    
    		<div class="d-none d-sm-flex justify-content-center align-items-center flex-column">
				<c:choose>
					<c:when test="${channel != null}">
						<h2 id="chatroomNickname" class="text-center m-0">${channel.channelNickname}</h2> 
						<span id="chatroomName" class="hidden">${channel.channelName}</span>
					</c:when>
					<c:otherwise>
						<!-- TODO: change it so that it shows the other person's nickname and username -->
						<h2 id="chatroomName" class="text-center m-0">${chatroomName}</h2> 
					</c:otherwise>

				</c:choose>
        		
        		<p class="text-success mb-1"><span id="number-connected">0</span> Online</p>
        	</div>
            
   			<div class="connecting">Connecting...</div>
    	        
    		<ul id="messageArea">
				<c:choose>
					<c:when test="${messages != null}">
						<c:forEach var="message" items="${messages}">
							<!-- TODO: format it correclty and show 'me' if users sent it and remove date if it it sent today (check yesterday if you want) -->
							<c:choose>
								<c:when test="${message.user.username.equals(username)}">
								<li class="chat-message sender">
									<span>Me</span>
									<p class="mb-0">${message.content}</p>
									
									<jsp:useBean id="now" class="java.util.Date"/>
									<fmt:formatDate value="${now}" pattern="MMM dd" var="today" />
									<fmt:formatDate value="${message.createdAt}" pattern="MMM dd" var="createdAt"/>
									<c:choose>
										<c:when test="${createdAt.equals(today)}">
											<p class="timestamp"><fmt:formatDate pattern="h:mm a" value="${message.createdAt}"/></p>
										</c:when>
										<c:otherwise>
											<p class="timestamp"><fmt:formatDate pattern="MMM dd h:mm a" value="${message.createdAt}"/></p>
										</c:otherwise>
									</c:choose>
								</li>
								</c:when>
								<c:otherwise>
								<li class="chat-message receiver">
									<span>${message.user.username}</span>
									<p class="mb-0">${message.content}</p>
									
									<jsp:useBean id="now2" class="java.util.Date"/>
									<fmt:formatDate value="${now2}" pattern="MMM dd" var="today2" />
									<fmt:formatDate value="${message.createdAt}" pattern="MMM dd" var="createdAt2"/>
									
									<c:choose>
										<c:when test="${createdAt2.equals(today2)}">
											<p class="timestamp"><fmt:formatDate pattern="h:mm a" value="${message.createdAt}"/></p>
										</c:when>
										<c:otherwise>
											<p class="timestamp"><fmt:formatDate pattern="MMM dd h:mm a" value="${message.createdAt}"/></p>
										</c:otherwise>
									</c:choose>
								</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:when>
				</c:choose>
				
			</ul>
            
    		<form id="messageForm" name="messageForm" nameForm="messageForm">
    			<div class="form-group mx-3">
        			<div class="input-group text-center">
            			<input type="text" id="message" placeholder="Type a message..." autocomplete="off" class="form-control"/>
                		<button type="submit" class="btn btn-primary btn-lg">
                			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-send" viewBox="0 0 16 16">
  								<path d="M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576 6.636 10.07Zm6.787-8.201L1.591 6.602l4.339 2.76 7.494-7.493Z"/>
							</svg>
						</button>
        			</div>
     			</div>
  			</form>
        </div>
    </div>
    
</t:base>