package com.kb.chitchat.controllers;


import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;

import com.kb.chitchat.models.ChatMessage;

@Controller
public class ChatController {

    // ! edit the mapping and routes to handle messages
    // every route is prefixed with /app, so we have /app/chat.sendMessage
    // /chat.sendMessage is handled by sendMessage
    @MessageMapping("/chat.sendMessage")
    @SendTo("/topic/public")
    public ChatMessage sendMessage(@Payload ChatMessage chatMessage) { // payload allows you to access on the front end
        return chatMessage;
    }

    // get all the messages to private "/topic/private"
    @MessageMapping("/chat.sendMessagePrivate")
    @SendTo("/topic/private")
    public ChatMessage sendMessagePrivate(@Payload ChatMessage chatMessage) { 
        return chatMessage;
    }

    @MessageMapping("/chat.sendMessageroom1")
    @SendTo("/topic/room1")
    public ChatMessage sendMessagePrivateRoom1(@Payload ChatMessage chatMessage) { 
        return chatMessage;
    }

    @MessageMapping("/chat.sendMessageroom2")
    @SendTo("/topic/room2")
    public ChatMessage sendMessagePrivateRoom2(@Payload ChatMessage chatMessage) { 
        return chatMessage;
    }
    
    // this route handles adding user
    @MessageMapping("/chat.addUser")
    @SendTo("/topic/public")
    public ChatMessage addUser(@Payload ChatMessage chatMessage,
                               SimpMessageHeaderAccessor headerAccessor) {
        // Add username in web socket session
        headerAccessor.getSessionAttributes().put("username", chatMessage.getSender());
        return chatMessage;
    }

}
