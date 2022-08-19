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

    <div id="chat-page" class="fade-in d-flex align-items-start justify-content-center w-100 text-white">
        <div class="chat-contxainer w-100 w-sm-75 w-lg-62">
            <div class="chat-header">
                    <h2>- <span id="chatroomName">${chatroomName}</span> - </h2>
                    <p>Welcome <span id="userName">${userName}</span>!</p>
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
        </div>
    </div>
    
</t:base>