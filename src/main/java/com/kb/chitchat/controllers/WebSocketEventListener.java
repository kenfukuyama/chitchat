package com.kb.chitchat.controllers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.config.WebSocketMessageBrokerStats;
import org.springframework.web.socket.messaging.SessionConnectedEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import com.kb.chitchat.models.ChatMessage;

// we listens to socket eventts (connect or disconnect)
@Component
public class WebSocketEventListener {

    // logger records event happned
    private static final Logger logger = LoggerFactory.getLogger(WebSocketEventListener.class);

    @Autowired
    private SimpMessageSendingOperations messagingTemplate;

    @Autowired
    private WebSocketMessageBrokerStats webSocketMessageBrokerStats;

    // we listens when the user connects
    @EventListener
    public void handleWebSocketConnectListener(SessionConnectedEvent event) {
        // there will be on consle, if you try to put it in the front
        logger.info("Received a new web socket connection");

        // StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());
        // String username = (String) headerAccessor.getSessionAttributes().get("username");
        // WebSocketMessageBrokerStats stats = new WebSocketMessageBrokerStats();

        // TODO disable for deployment since it prints everytime user connects and disconnects
        System.out.println(webSocketMessageBrokerStats.getWebSocketSessionStatsInfo());
    }


    // we listens when the user disconnects
    @EventListener
    public void handleWebSocketDisconnectListener(SessionDisconnectEvent event) {
        // headerAccessor finds metadata
        StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());
        String username = (String) headerAccessor.getSessionAttributes().get("username");

        if(username != null) {
            logger.info("User Disconnected : " + username);

            // creats nwew chatMessage, that tells user has left
            ChatMessage chatMessage = new ChatMessage();
            chatMessage.setType(ChatMessage.MessageType.LEAVE);
            chatMessage.setSender(username);

            // board cast to everyone
            // this is similar to            @SendTo("/topic/public"), return chatMessage
            messagingTemplate.convertAndSend("/topic/public", chatMessage);
            

        }
        System.out.println(webSocketMessageBrokerStats.getWebSocketSessionStatsInfo());
    }
}
