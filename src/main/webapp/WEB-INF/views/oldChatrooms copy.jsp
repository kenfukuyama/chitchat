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
    
    <!-- enter the user page -->
    <div id="username-page" class="fade-in d-flex vh-100 align-items-center text-white">
        <div class="container username-page-container text-center">
            <h1 class="title">What's your username?</h1>
            <form id="usernameForm" name="usernameForm" class="d-flex justify-content-center align-items-center flex-column">
                <div class="form-group w-25">
                    <input type="text" id="name" placeholder="username" autocomplete="off" class="form-control" />
                </div>
                <h6 class="m-2 text-center">Select Your Room</h6>
                <div class="d-flex gap-3">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="room" id="room" value="room1" checked>
                            <label class="form-check-label" for="room1">Room 1</label>
                        </div>
                        
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="room" id="room" value="room2">
                            <label class="form-check-label" for="room2">Room 2</label>
                        </div>
                </div>
                <div class="form-group">
                    <button type="submit" class="username-submit mt-3">Start Chatting</button>
                </div>
    
            </form>
        </div>
    </div>
    
    
    <div id="chat-page" class="fade-in d-none align-items-center justify-content-center text-white">
        <div class="chat-container ">
            <div class="chat-header">
                    <h2 id="room-name">Chat Room</h2>
                    <p id="username"></p>
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
                <div class="form-group">
                    <div class="input-group clearfix text-center">
                        <input type="text" id="message" placeholder="Type a message..." autocomplete="off" class="form-control"/>
                        <button type="submit" class="primary">Send</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

</t:base>