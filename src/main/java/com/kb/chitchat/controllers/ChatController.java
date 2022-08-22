package com.kb.chitchat.controllers;

import org.springframework.messaging.handler.annotation.DestinationVariable;
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

    // routes for rooms 
    @MessageMapping("/chat.sendMessage{roomSelection}")
    @SendTo("/topic/{roomSelection}")
    public ChatMessage sendMessageRoom(@Payload ChatMessage chatMessage, @DestinationVariable String roomSelection) { 
        return chatMessage;
    }


    // this route handles adding user
    @MessageMapping("/chat.addUser{roomSelection}")
    @SendTo("/topic/{roomSelection}")
    public ChatMessage addUser(@Payload ChatMessage chatMessage,
                               SimpMessageHeaderAccessor headerAccessor,
                               @DestinationVariable String roomSelection) {
        // Add username in web socket session
        headerAccessor.getSessionAttributes().put("username", chatMessage.getSender());
        headerAccessor.getSessionAttributes().put("roomSelection", roomSelection);
        chatMessage.setOnlineNumber(WebSocketEventListener.connectionSet.size());
        System.out.println("connection set: " + WebSocketEventListener.connectionSet.size());
        return chatMessage;
    }
    

}