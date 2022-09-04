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

    <div id="username-page" class="fade-in d-flex align-items-center text-white">
        <div class="container username-page-container text-center pt-5 vh-100 styled-text text-white">
            <h2 class="mt-5">Select your room, ${username}</h2>
            <p class="text-success"> <span class=""></span> 1203 online</p>
			<div class="d-flex justify-content-center">
            	<div class="input-group search-bar p-4 w-md-75 w-lg-50">
                	<input type="text" class="form-control rounded live-search-box regular" placeholder="Search Channels" aria-label="Search Channels"
                   		aria-describedby="search-addon" />
                	<button type="button" class="btn btn-primary"><i class="bi bi-search"></i></button>
            	</div>
            </div>

            <c:choose>
                <c:when test="${user.registered == 1}">
                    <div class="d-flex justify-content-center align-items-center gap-3 mb-5">
                        <a class="styled-button btn btn-light" href="/users/friends">Friends</a>
						<a class="styled-button btn btn-light" href="/users/dashboard">Messages</a>
                        <a class="styled-button btn btn-light" href="/users/chatrooms">My Rooms</a>
                    </div>
                </c:when>
            </c:choose>
            
            <!--#################################### START CHANNEL SELECTION  #######################################-->
            
            <form action="/chatrooms/enter" method="post" name="chatroomNameForm" class="chatroomSelection">
                <div class="row styled-text text-white mt-1">
                	<c:set var="count" value="0" scope="page"/>
					<c:forEach var="thisChannel" items="${channelMap}">
						<c:if test="${thisChannel.key.isPublic != 0}">
						<div class="col-sm-6 col-md-4 col-lg-3 category-selector live-search-list">
							<p class="channelNickname">${thisChannel.key.channelNickname}</p>

							<c:choose>
								<c:when test="${count == 0}">
									<input type="radio" name="chatroomName" id="${thisChannel.key.channelName}" value="${thisChannel.key.channelName}" checked="checked">
								</c:when>
								<c:otherwise>
									<input type="radio" name="chatroomName" id="${thisChannel.key.channelName}" value="${thisChannel.key.channelName}">
								</c:otherwise>
							</c:choose>
							<c:set var="count" value="${count+1}" scope="page"/>
							<label class="category-image channel bg-primary ${thisChannel.key.channelName}" for="${thisChannel.key.channelName}" id="previewBtn" data-bs-toggle="modal" data-bs-target="#${thisChannel.key.channelName.concat(thisChannel.key.id)}"></label>  
						</div>
						</c:if>
					</c:forEach>
				</div>
				
					
            	<div class="form-group fixed-bottom mb-4">
            		<button type="submit" class="chatrooms-submit styled-button btn btn-lg w-md-21 w-lg-16 w-xl-14 w-xxl-12">Let's Chat <i class="bi-arrow-right-short"></i></button>
            	</div>
    
        	</form>
        	<!--#################################### END CHANNEL SELECTION  #######################################-->
    	</div>
	</div>
	
	
	<c:forEach var="thisChannel" items="${channelMap}">
	<div class="modal" id="${thisChannel.key.channelName.concat(thisChannel.key.id)}" data-easein="expandIn" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  		<div class="modal-dialog">
    		<div class="modal-content">
    							
      			<!-- Modal body -->
      			<div class="modal-body">
      								
        			<div class="row modal-content-row">

        				<div class="col-12 col-md-6 text-start preview-left pe-2 h-md-100">
        					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        					<div>
        						<h1 class="display-4 preview-title text-white">${thisChannel.key.channelNickname}</h1>
        					</div>
        										
        					<div class="d-flex justify-content-between align-items-center mb-2">
        						<span class="text-success ps-1 lead">73 Online</span>
      							<div class="d-flex">
      								<form action="/chatrooms/enter" method="post" name="chatroomNameForm" class="chatroomSelection">
      									<input type="hidden" name="chatroomName" id="${thisChannel.key.channelName}" value="${thisChannel.key.channelName}">
        								<button type="submit" class="user-submit btn btn-lg">Enter Room</button>
        							</form>
        							
      							</div>	
      						</div>
      											
        					<p class="mb-2 ps-1 text-white">${thisChannel.key.description}</p>
        										
      						<div class="frame d-none d-md-block" style="background-image: url('/assets/images/publicChannels/${thisChannel.key.channelName}.jpg');">
      						</div>	
      						
      					</div>
       							        									
        				<div class="col-12 col-md-6 ps-2 preview-right h-md-100">
        					<h6 class="display-6 text-center text-white">Recent Messages</h6>
        					<ul id="messageArea" class="preview-page">
      							<c:forEach var="message" items="${thisChannel.value}">
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
      							</ul>
        					</div>
      								
						</div>

    				</div>
  				</div>
			</div>
		</div>
   </c:forEach>
    
</t:base>