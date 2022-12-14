package com.kb.chitchat.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;

import com.kb.chitchat.models.ChatMessage;
import com.kb.chitchat.models.PrivateMessage;
import com.kb.chitchat.models.PublicMessage;
import com.kb.chitchat.services.FriendshipService;
import com.kb.chitchat.services.PrivateMessageService;
import com.kb.chitchat.services.PublicChannelService;
import com.kb.chitchat.services.PublicMessageService;
import com.kb.chitchat.services.UserService;

@Controller
public class ChatController {
    @Autowired 
    private UserService userService;

    @Autowired
    private PublicChannelService publicChannelService;

    @Autowired
    private PublicMessageService publicMessageService;

    @Autowired
    private FriendshipService friendshipService;

    @Autowired
    private PrivateMessageService privateMessageService;


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
        // System.out.println(chatMessage.toString());
        PublicMessage publicMessage = new PublicMessage();
        publicMessage.setPublicChannel(publicChannelService.findPublicChannel(Long.parseLong(chatMessage.getChannelId())));
        publicMessage.setUser(userService.findUser(Long.parseLong(chatMessage.getSenderId())));
        publicMessage.setContent(chatMessage.getContent());
        publicMessageService.savePublicMessage(publicMessage);
        return chatMessage;
    }

    // routes for private messages
    @MessageMapping("/chat.sendMessageDM{roomSelection}")
    @SendTo("/topic/{roomSelection}")
    public ChatMessage sendDM(@Payload ChatMessage chatMessage, @DestinationVariable String roomSelection) { 
        PrivateMessage privateMessage = new PrivateMessage();
        privateMessage.setFriendship(friendshipService.findFriendship(Long.parseLong(chatMessage.getChannelId())));
        privateMessage.setSender(userService.findUser(Long.parseLong(chatMessage.getSenderId())));
        privateMessage.setContent(chatMessage.getContent());
        privateMessage.setIsRead(0);
        privateMessageService.savePrivateMessage(privateMessage);
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