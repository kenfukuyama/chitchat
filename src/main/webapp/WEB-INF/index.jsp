<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- bootstrap css -->
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css"/>
    <!-- css -->
    <link rel="stylesheet" href="/css/style.css">
    <!-- bootstrap javascript -->
    <script defer src="/webjars/jquery/jquery.min.js"></script>
    <script defer src="/webjars/bootstrap/js/bootstrap.min.js"></script>

    <!-- javascript -->
    <script defer type="text/javascript" src="/js/script.js"></script>

    <!-- javascript for websocket library -->
    <script defer src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
    <script defer src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    
    
    <title>document</title>
</head>
<body>
    <noscript>
        <h2>Sorry! Your browser doesn't support Javascript</h2>
    </noscript>
    
    <!-- enter the user page -->
    <div id="username-page">
        <div class="username-page-container">
            <h1 class="title">Type your username</h1>
            <form id="usernameForm" name="usernameForm">
                <div class="form-group">
                    <input type="text" id="name" placeholder="Username" autocomplete="off" class="form-control" />
                </div>
                <h6 class="m-2" style="text-align: left;">Select Your Room</h6>
                <div class="form-check d-flex gap-2 justify-content-center">
                    <input class="form-check-input" type="radio" name="room" id="room" value="room1" checked>
                    <label class="form-check-label" for="room1">Room 1</label>
                </div>
    
                <div class="form-check d-flex gap-2 justify-content-center">
                    <input class="form-check-input" type="radio" name="room" id="room" value="room2">
                    <label class="form-check-label" for="room2">Room 2</label>
                </div>
                <div class="form-group">
                    <button type="submit" class="accent username-submit">Start Chatting</button>
                </div>
    
            </form>
        </div>
    </div>
    
    
    <div id="chat-page" class="hidden">
        <div class="chat-container">
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
                    <div class="input-group clearfix">
                        <input type="text" id="message" placeholder="Type a message..." autocomplete="off" class="form-control"/>
                        <button type="submit" class="primary">Send</button>
                    </div>
                </div>
            </form>
        </div>
    </div>


   
</body>
</html>