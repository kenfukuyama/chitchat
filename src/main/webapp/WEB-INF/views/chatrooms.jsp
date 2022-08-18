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

    <div id="username-page" class="fade-in d-flex vh-100 align-items-center text-white">
        <div class="container username-page-container text-center">
            <h1 class="title">Select Your Room</h1>
            <p id="userName">Welcome, ${userName}!</p>
            <form action="/chatrooms/enter" method="post" chatroomNameForm" name="chatroomNameForm" class="d-flex justify-content-center align-items-center flex-column">
                <div class="d-flex gap-3">
                        <!-- <div class="form-check">
                            <input class="form-check-input" type="radio" name="chatRoomName" id="room" value="room1" checked>
                            <label class="form-check-label" for="room1">Room 1</label>
                        </div> -->
                        <!-- <div class="form-check">
                            <input class="form-check-input" type="radio" name="chatRoomName" id="room" value="room2">
                            <label class="form-check-label" for="room2">Room 2</label>
                        </div> -->
                        <div class="form-group">
                            <label for="chatroomName">Chat Room</label>
                            <input type="text" class="form-control" id="chatroomName" name="chatroomName" placeholder="Enter Room Name">
                        </div>
                        
                </div>
                <div class="form-group">
                    <button type="submit" class="username-submit mt-3">Enter</button>
                </div>
    
            </form>
        </div>
    </div>
    
    
</t:base>