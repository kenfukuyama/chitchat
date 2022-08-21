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

<<<<<<< HEAD
	<span id="userName" class="d-none">${userName}</span>
	
    <div id="chat-page" class="fade-in d-flex align-items-center justify-content-center vh-100 w-100 styled-text text-white">
        <div class="chat-container w-100 w-sm-75 w-lg-62 w-xxl-50">
    
    		<div class="d-flex justify-content-center align-items-end gap-2 mb-2">
        		<h2 id="chatroomName" class="text-center m-0">${chatroomName}</h2> 
        		<p class="text-center text-success m-0"><span id="number-connected">0</span> Online</p>
        	</div>
            
   			<div class="connecting">Connecting...</div>
    	        
    		<ul id="messageArea"></ul>
            
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
=======
    <div id="chat-page" class="fade-in d-flex align-items-start justify-content-center w-100 text-white">
        <div class="chat-container w-100 w-sm-75 w-lg-62">
            <div class="chat-header">
                    <h2 id="chatroomName">${chatroomName}</h2>
                    <p>Welcome, <span id="nickname">${nickname}</span></p>
                    <span class="hidden" id="username">${username}</span>
                <div class="online-number">
                    <span id="number-connected">0</span> Online
                </div>
            </div>
            <div class="connecting">
                Connecting...
            </div>
            <ul id="messageArea">

            </ul>
            <form id="messageForm" name="messageForm" nameForm="messageForm">
                <div class="form-group mx-3">
                    <div class="input-group clearfix text-center">
                        <input type="text" id="message" placeholder="Type a message..." autocomplete="off" class="form-control"/>
                        <button type="submit" class="primary">Send</button>
                    </div>
                </div>
            </form>
>>>>>>> d385e6c9687a62ea5384587cfccb3cccdf4d2de8
        </div>
    </div>
    
</t:base>