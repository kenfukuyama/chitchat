<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "t" tagdir="/WEB-INF/tags" %>

<title>chit-chat</title>
<t:base> 
<div class="d-flex vh-100 align-items-center justify-content-center flex-column fade-in">
	<h3 class="display-3 landing-title">Chit Chat</h3>
	<p class="lead landing-text">the messaging app for you</p>
	
	<div class="d-flex">
		<a class="btn btn-light btn-lg mt-2" href="/guests/new"><strong>Start Chatting</strong> <i class="bi-arrow-right-short"></i></a>
	</div>
</div>   

</t:base>
	
