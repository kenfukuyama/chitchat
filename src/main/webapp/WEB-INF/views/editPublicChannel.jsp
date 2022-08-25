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
			<h3 class="mb-2">Edit ${channel.channelNickname}</h3>
			<hr />
			<form:form action="/channels/${channel.id}" method="post" modelAttribute="channel" class="p-4 w-md-75 w-lg-50">
				<input type="hidden" name="_method" value="put"/>
				<form:input type="hidden" path="creator" value="${userId}"></form:input>
				<div class="mb-3">
					<form:label path="channelName" class="form-label mb-1">Channel Name </form:label>
					<form:input path="channelName" type="text" class="form-control" placeholder="channelName"
						autocomplete="off" />
					<small>
						<form:errors class="text-danger" path="channelName" />
					</small>
				</div>

				<div class="mb-3">
					<form:label path="channelNickname" class="form-label mb-1">Channel Nickname </form:label>
					<form:input path="channelNickname" type="text" class="form-control" placeholder="channelNickname"
						autocomplete="off" />
					<small>
						<form:errors class="text-danger" path="channelNickname" />
					</small>
				</div>

				<div class="mb-3">
					<form:label path="description" class="form-label mb-1">Description (30 to 100 characters)
					</form:label>
					<form:textarea path="description" type="text" class="form-control" placeholder="description"
						autocomplete="off" />
					<small>
						<form:errors class="text-danger" path="description" />
					</small>
				</div>
				<div class="d-flex justify-content-between">
					<div class="d-flex align-items-start">
						<form:input type="hidden" path="isPublic" value="1"></form:input>
						<div class="form-check form-switch">
							<input type="hidden" name="privacySwitch">
							<c:choose>
								<c:when test='${channel.isPublic == "1"}'>
									<input class="form-check-input" type="checkbox" name="privacySwitch" value="0"
								id="flexSwitchCheckChecked">
								</c:when>
								<c:otherwise>
									<input class="form-check-input" type="checkbox" name="privacySwitch" value="0"
								id="flexSwitchCheckChecked" checked>
								</c:otherwise>
							</c:choose>
							<label class="form-check-label" for="flexSwitchCheckChecked">Private</label>
						</div>

					</div>
					<div class="d-flex justify-content-end gap-3">
						<input type="submit" value="Update" class="user-submit btn">
					</div>

				</div>

			</form:form>
			<a href="/channels/new" >Back To My Rooms</a>


		</div>

	</div>
</div>

    
    
    
</t:base>