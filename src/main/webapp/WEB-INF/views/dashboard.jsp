<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "t" tagdir="/WEB-INF/tags" %>

<title>Dashboard</title>
<t:base>
<script defer type="text/javascript" src="/js/dm.js"></script>
<div class="container-fluid vh-100 d-flex align-items-center justify-content-center">
	<!-- hidden variables -->
	<span id="username" class="d-none">${username}</span>
	<span id="nickname" class="d-none">${nickname}</span>

	<span class="d-none" id="userId">${id}</span>
	<span class="d-none" id="channelId">${selectedFriendship.id}</span>

	<jsp:useBean id="now" class="java.util.Date"/>

	<div class="container-fluid dashboard-container fade-in">
	<div class="row">
		<div class="col-5 dashboard-left">
			<h3 class="text-center p-3 dashboard-header">${nickname}&nbsp;(<small>@${username}</small>) <br> Your Messages</h3>
	
			<div class="d-flex justify-content-center">
            	<div class="input-group search-bar px-4 pb-4 w-100">
                	<input type="text" class="form-control rounded live-search-box regular" placeholder="Search Messages" aria-label="Search Messages"
                   		aria-describedby="search-addon" />
                	<button type="button" class="btn btn-primary"><i class="bi bi-search"></i></button>
            	</div>
            </div>
            
             <div class="tab-form">
                <div class="tab-header mb-4">
                    <div class="active">Current Chats</div>
                    <div>Start New Chat</div>
                </div>
                
                 <div class="tab-body">
                    <div class="currentChats active">
	
						<ul class="dashboard-contacts ps-0">
							<c:forEach var="i" items="${friendsWithMessagesSizeArr}">
								<li class="live-search-list convo started-convo">
									<div class="d-flex align-items-center dashboard-contact justify-content-between">
										<div class="w-75">
											<strong>${friendsWithMessages[i].nickname} (<small><em>@${friendsWithMessages[i].username}</em></small>)</strong><br/>
												<span class="dashboard-contact-info">${recentMessages[i].content}</span>
					
												<fmt:formatDate value="${now}" pattern="MMM dd" var="today" />
												<fmt:formatDate value="${recentMessages[i].createdAt}" pattern="MMM dd" var="createdAt" />
												<c:choose>
													<c:when test="${createdAt.equals(today)}">
														<p class="timestamp dash">
															<small><fmt:formatDate pattern="h:mm a" value="${recentMessages[i].createdAt}" /></small>
														</p>
													</c:when>
													<c:otherwise>
														<p class="timestamp dash">
															<small><fmt:formatDate pattern="MMM dd h:mm a" value="${recentMessages[i].createdAt}" /></small>
														</p>
													</c:otherwise>
												</c:choose>
										</div>
						
					
										<form action="/chatrooms/private/enter" method="post" name="privateChatForm" class="chatroomSelection">
											<input type="hidden" name="loggedInUserId" value="${loggedInUser.id}">
											<input type="hidden" name="userId" value="${friendsWithMessages[i].id}">
											<button type="submit" class="user-submit btn btn-lg"><i class="bi bi-chat"></i></button>
										</form>
									</div>
								</li>
							</c:forEach>
						</ul>
					</div>
					<div class="newChat">
						<ul class="dashboard-contacts ps-0">
							<c:forEach var="friend" items="${friendWithOutMessages}">
								<li class="live-search-list convo new-convo">
									<div class="d-flex align-items-center dashboard-contact justify-content-between">
										<div>
											<strong>${friend.nickname} (<small><em>@${friend.username}</em></small>) </strong>
										</div>

										<form action="/chatrooms/private/enter" method="post" name="privateChatForm" class="chatroomSelection mb-0">
											<input type="hidden" name="loggedInUserId" value="${loggedInUser.id}">
											<input type="hidden" name="userId" value="${friend.id}">
											<button type="submit" class="user-submit btn">Start Chatting</button>
										</form>
									</div>
								</li>
							</c:forEach>
						</ul>
					
					</div>
				</div>
			</div>
			
		</div>

		<!-- Chatting page  -->
		<div class="col-7 text-center bg-dark dashboard-right">
			<div id="chat-page" class="d-flex align-items-center justify-content-center w-100 styled-text text-white">
				<div class="chat-container w-100">
						
					<c:choose>
						<c:when test="${selectedFriendship == null}">
							<h4 class="fade-in"><strong>Select Friends to Start Chatting</strong></h4>
						</c:when>
						<c:otherwise>
							<div class="d-flex justify-content-center align-items-center flex-column">
								<!-- TODO: change it so that it shows the other person's nickname and username -->
								<h2 id="chatroomName" class="d-none text-center">${selectedFriendship.name}</h2>
								<c:choose>
									<c:when test="${selectedFriendship.user.id == id}">
										<h2 id="chatroomNickname" class="text-center mt-3">${selectedFriendship.friend.nickname} (<em>@${selectedFriendship.friend.username}</em>) </h2>
									</c:when>
									<c:otherwise>
										<h2 id="chatroomNickname" class="text-center mt-3">${selectedFriendship.user.nickname} (<em>@${selectedFriendship.user.username}</em>) </h2>
									</c:otherwise>
								</c:choose>
								<p class="text-success m-0 d-none"><span id="number-connected">0</span> Online</p>
							</div>
							
							<div class="connecting">Connecting...</div>

							<ul id="messageArea" class="messageAreaPrivate">
								<c:choose>
									<c:when test="${messages != null}">
										<c:forEach var="message" items="${messages}">
											<!-- TODO: format it correclty and show 'me' if users sent it and remove date if it it sent today (check yesterday if you want) -->
											<c:choose>
												<c:when test="${message.sender.username.equals(username)}">
													<li class="chat-message sender">
														<span>Me</span>
														<p class="mb-0">${message.content}</p>
							
														<fmt:formatDate value="${now}" pattern="MMM dd" var="today" />
														<fmt:formatDate value="${message.createdAt}" pattern="MMM dd" var="createdAt" />
														<c:choose>
															<c:when test="${createdAt.equals(today)}">
																<p class="timestamp">
																	<fmt:formatDate pattern="h:mm a" value="${message.createdAt}" />
																</p>
															</c:when>
															<c:otherwise>
																<p class="timestamp">
																	<fmt:formatDate pattern="MMM dd h:mm a" value="${message.createdAt}" />
																</p>
															</c:otherwise>
														</c:choose>
													</li>
												</c:when>
												<c:otherwise>
													<li class="chat-message receiver">
														<span>${message.sender.nickname}</span>
														<p class="mb-0">${message.content}</p>
							
														<jsp:useBean id="now2" class="java.util.Date" />
														<fmt:formatDate value="${now2}" pattern="MMM dd" var="today2" />
														<fmt:formatDate value="${message.createdAt}" pattern="MMM dd" var="createdAt2" />
							
														<c:choose>
															<c:when test="${createdAt2.equals(today2)}">
																<p class="timestamp">
																	<fmt:formatDate pattern="h:mm a" value="${message.createdAt}" />
																</p>
															</c:when>
															<c:otherwise>
																<p class="timestamp">
																	<fmt:formatDate pattern="MMM dd h:mm a" value="${message.createdAt}" />
																</p>
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
										<input type="text" id="message" placeholder="Type a message..." autocomplete="off" class="form-control" />
										<button type="submit" class="btn btn-primary btn-lg">
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-send"
												viewBox="0 0 16 16">
												<path
													d="M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576 6.636 10.07Zm6.787-8.201L1.591 6.602l4.339 2.76 7.494-7.493Z" />
											</svg>
										</button>
									</div>
								</div>
							</form>

						</c:otherwise>
						

					</c:choose>
					
				</div>
			</div>
			</div>

		</div>
	</div>
</div>
</div>
</t:base>
	
