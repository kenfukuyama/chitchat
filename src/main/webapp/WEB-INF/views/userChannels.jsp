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
        		<h3 class="mb-2">Create New Room</h3>
				<hr/>
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
				
				<div class="mb-3">
                    <form:label path="description" class="form-label mb-1">Description (30 to 100 characters) </form:label>
                    <form:textarea path="description" type="text" class="form-control" placeholder="description" autocomplete="off"/>
                    <small><form:errors  class="text-danger" path="description" /></small>
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
    
				<h3 class="mt-4">Your Chatrooms</h3>
				<hr/>
            
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
                            		<label class="category-image bg-info ${channel.channelName}" for="${channel.channelName}" id="previewBtn" data-bs-toggle="modal" data-bs-target="#${channel.channelName.concat(channel.id)}"></label>   
                            		
                            		<div class="modal" id="${channel.channelName.concat(channel.id)}" data-easein="expandIn" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            			<div class="modal-dialog">
                            				<div class="modal-content">
                            					<div class="modal-body">
                            						<div class="row">
                            							<div class="col-6 frame" style="background-image: url('/assets/images/publicChannels/${thisChannel.key.channelName}.jpg');"></div>
                            							<div class="col-6 text-start">
                            								<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        													<div class="d-flex align-items-center">
        														<h1 class="display-4 p-0 preview-title">${channel.channelNickname}</h1>&nbsp;&nbsp;<span class="text-success lead">55 Online</span>
        													</div>
        													<p class="mb-2">This is a detailed description of ${channel.channelNickname}. What a great description. So good.</p>
        										
        													<div class="d-flex mb-3">
        														<button type="submit" class="user-submit btn btn-lg">Enter Room</button>
      															<c:if test="${channel.creator.username.equals(username)}">
      																<button type="submit" class="btn btn-info">Edit</button>
      																<button type="submit" class="btn btn-danger">Delete</button>
      															</c:if>
      												
      														</div>
                            								
                            							</div>
                            						</div>
                            					</div>
                            				</div>
                            			</div>                  
                        			</div>
                        		</div>
                    		</c:forEach>
                		</div>  
            		</form>

						<!-- <form action="/chatrooms/enter" method="post" name="chatroomNameForm" class="chatroomSelection"> -->
						<div class="row styled-text text-white mt-1">
							<c:forEach var="channel" items="${userChannels}">
								<c:choose>
									<c:when test='${channel.isPublic != "0"}'>
										<div class="col-sm-6 col-md-4 col-lg-3 category-selector live-search-list">
											<p>${channel.channelNickname}</p>
											<c:choose>
												<c:when test="${channel == userChannels[0]}">
													<input type="radio" name="chatroomName" id="${channel.channelName}"
														value="${channel.channelNickname}" checked="checked">
												</c:when>
												<c:otherwise>
													<input type="radio" name="chatroomName" id="${channel.channelName}"
														value="${channel.channelName}">
												</c:otherwise>
											</c:choose>
											<label class="category-image bg-info ${channel.channelName}" for="${channel.channelName}"></label>
											<div class="d-flex justify-content-center gap-2 mt-1">
												<div><a href="/channels/${channel.channelName}/edit" class="btn btn-info">Edit</a></div>
												<div class="btn btn-danger">
													<form action="/channels/${channel.id}" method="post">
														<input type="hidden" name="_method" value="delete">
														<input class="btn" type="submit" value="Delete">
													</form>
												</div>
											</div>
										</div>
						
									</c:when>
								</c:choose>
						
							</c:forEach>
						</div>
						<!-- </form> -->

				</div>
				
				<div class="privateRoom">
						<!-- <form action="/chatrooms/enter" method="post" name="chatroomNameForm" class="chatroomSelection"> -->
							<div class="row styled-text text-white mt-1">
								<c:forEach var="channel" items="${userChannels}">
									<c:choose>
										<c:when test='${channel.isPublic == "0"}'>
											<div class="col-sm-6 col-md-4 col-lg-3 category-selector live-search-list">
												<p>${channel.channelNickname}</p>
												<c:choose>
													<c:when test="${channel == userChannels[0]}">
														<input type="radio" name="chatroomName" id="${channel.channelName}"
															value="${channel.channelNickname}" checked="checked">
													</c:when>
													<c:otherwise>
														<input type="radio" name="chatroomName" id="${channel.channelName}"
															value="${channel.channelName}">
													</c:otherwise>
												</c:choose>
												<label class="category-image bg-info ${channel.channelName}" for="${channel.channelName}"></label>
												<div class="d-flex justify-content-center gap-2 mt-1">
													<div><a href="/channels/${channel.channelName}/edit" class="btn btn-info">Edit</a></div>
													<div class="btn btn-danger">
														<form action="/channels/${channel.id}" method="post">
															<input type="hidden" name="_method" value="delete">
															<input class="btn" type="submit" value="Delete">
														</form>
													</div>
												</div>
											</div>
							
										</c:when>
									</c:choose>
							
								</c:forEach>
							</div>
							<!-- </form> -->
				</div>
           </div>
            
        </div>

    </div>
</div>
            

    
    
    
</t:base>