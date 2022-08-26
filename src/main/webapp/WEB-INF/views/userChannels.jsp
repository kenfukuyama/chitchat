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
        		<form:form action="/channels/new" method="post" modelAttribute="channel" class="p-5 w-md-75 w-lg-50">
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
    
    			<hr/>
    			
				<h3 class="mt-4">Your Chatrooms</h3>
            
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
							</div>
				
				
							<div class="privateRoom">
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
							</div>
           				</div>
            
        			</div>

    			</div>
			</div>
            

    </div>
    
    
</t:base>