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
        <div class="container username-page-container text-center pt-5 vh-100 styled-text text-white">
            <h2 class="mt-5">Select your room, ${username}</h2>
			<!-- TODO: fix the alignment of online number -->
            <p class="text-success"> <span class="" style="">•</span> 1203 online</p>
			<div class="d-flex justify-content-center">
            	<div class="input-group p-4 w-md-75 w-lg-50">
                	<input type="text" class="form-control rounded live-search-box regular" placeholder="Search Channels" aria-label="Search Channels"
                   		aria-describedby="search-addon" />
                	<button type="button" class="btn btn-primary"><i class="bi bi-search"></i></button>
            	</div>
            </div>

            <c:choose>
                <c:when test="${user.registered == 1}">
                    <div class="d-flex justify-content-center align-items-center gap-3 mb-5">
                        <a class="styled-button btn btn-light" href="/users/friends">+ Add Friend</a>
                        <a class="styled-button btn btn-light" href="/users/chatrooms">+ Create Room</a>
                    </div>
                </c:when>
            </c:choose>
            
            <form action="/chatrooms/enter" method="post" name="chatroomNameForm" class="chatroomSelection">
                <div class="row styled-text text-white mt-1">
					<c:forEach var="channel" items="${publicChannels}">
						<div class="col-sm-6 col-md-4 col-lg-3 category-selector live-search-list">
							<p class="channelNickname">${channel.channelNickname}</p>

							<c:choose>
								<c:when test="${channel == publicChannels[0]}">
									<input type="radio" name="chatroomName" id="${channel.channelName}" value="${channel.channelName}" checked="checked">
								</c:when>
								<c:otherwise>
									<input type="radio" name="chatroomName" id="${channel.channelName}" value="${channel.channelName}">
								</c:otherwise>
							</c:choose>
							<label class="category-image channel bg-primary ${channel.channelName}" for="${channel.channelName}" id="previewBtn" data-bs-toggle="modal" data-bs-target="#${channel.channelName.concat(channel.id)}"></label>  
						</div>
  
  						<div class="modal" id="${channel.channelName.concat(channel.id)}" data-easein="expandIn" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  							<div class="modal-dialog">
    							<div class="modal-content">

      								<div class="modal-header">
        								<h4 class="modal-title">${channel.channelNickname}</h4>&nbsp;&nbsp;<small><span class="text-success mb-0">56 people in this room</span></small>
        								<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      								</div>

      								<!-- Modal body -->
      								<div class="modal-body">
      						
        							<p>This is a description for ${channel.channelNickname}. letsdfsadfklsdjfasdlfkasdjflasdkfjasdlfasdjflasdkfjasdlfasdjflasdfjasdlfasdjflasdkfjasdlfajsdflasdfkajdslfkjadsflsadkfjsadlfjasdf</p>
      								</div>

      								<!-- Modal footer -->
      								<div class="modal-footer d-flex">
      								
        							<button type="submit" class="user-submit btn">Enter Room</button>
      								<c:if test="${channel.creator.username.equals(username)}">
      								<button type="submit" class="btn btn-info">Edit</button>
      								<button type="submit" class="btn btn-danger">Delete</button>
      								</c:if>
      								</div>

    								</div>
  								</div>
							</div>
					</c:forEach>
				</div>
				
					
                <div class="form-group fixed-bottom mb-4">
                    <button type="submit" class="chatrooms-submit styled-button btn btn-lg w-md-21 w-lg-16 w-xl-14 w-xxl-12">Let's Chat <i class="bi-arrow-right-short"></i></button>
                </div>
    
            </form>
        </div>
    </div>
    
    
</t:base>