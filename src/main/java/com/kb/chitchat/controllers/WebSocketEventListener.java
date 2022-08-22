package com.kb.chitchat.controllers;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

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
import org.springframework.web.socket.messaging.SessionSubscribeEvent;

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

    public static Set<String> connectionSet = Collections.newSetFromMap(new ConcurrentHashMap<String, Boolean>());
    public static Map<String, Integer> connectionMaps = new HashMap<String, Integer>();


    // we listens when the user connects
    @EventListener
    public void handleWebSocketConnectListener(SessionConnectedEvent event) {
        // there will be on consle, if you try to put it in the front
        logger.info("Received a new web socket connection");

        StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage()); 
        connectionSet.add(headerAccessor.getSessionId());
        // headerAccessor.getSessionAttributes().put("hel", "hffefe");

        // headerAccessor.setHeader("connectionSet", connectionSet);

        // String username = (String) headerAccessor.getSessionAttributes().get("username");
        // WebSocketMessageBrokerStats stats = new WebSocketMessageBrokerStats();

        // TODO disable for deployment since it prints everytime user connects and disconnects
        System.out.println("Connection:   " + webSocketMessageBrokerStats.getWebSocketSessionStatsInfo());
        // System.out.println("User sets:    " + connectionSet);
        // System.out.println("connection sets from session:" + headerAccessor);
        // System.out.println("connection sets from session:" + headerAccessor.getHeader("connectionSet"));
    }

    // we there is a new subscription
    @EventListener
    public void handleWebSocketSubscribeListener(SessionSubscribeEvent event) {
        // there will be on consle, if you try to put it in the front
        logger.info("Received a new subscription");

        // TODO: keep track of online numbers in connectionMaps
        // StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage()); 

        // System.out.println(headerAccessor.getDestination());
        // System.out.println(headerAccessor.getSessionAttributes());
        // System.out.println(headerAccessor.getHeader("connectionSet"));

        // StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());
        // String username = (String) headerAccessor.getSessionAttributes().get("username");
        // WebSocketMessageBrokerStats stats = new WebSocketMessageBrokerStats();
        

        // TODO disable for deployment since it prints everytime user connects and disconnects
        System.out.println("Subscription: " + webSocketMessageBrokerStats.getWebSocketSessionStatsInfo());
    }

    // we listens when the user disconnects
    @EventListener
    public void handleWebSocketDisconnectListener(SessionDisconnectEvent event) {
        // headerAccessor finds metadata
        StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());
        String username = (String) headerAccessor.getSessionAttributes().get("username");
        String roomSelection = (String) headerAccessor.getSessionAttributes().get("roomSelection");

        if(username != null) {
            logger.info("User Disconnected : " + username);
            connectionSet.remove(headerAccessor.getSessionId());
            // System.out.println("User sets:    " + connectionSet);

            // creats nwew chatMessage, that tells user has left
            ChatMessage chatMessage = new ChatMessage();
            chatMessage.setType(ChatMessage.MessageType.LEAVE);
            chatMessage.setSender(username);
            chatMessage.setOnlineNumber(connectionSet.size());

            // board cast to everyone
            // this is similar to            @SendTo("/topic/public"), return chatMessage
            // System.out.println(session.getAttribute("chatroomName"));
            messagingTemplate.convertAndSend("/topic/" + roomSelection, chatMessage);

        }
        System.out.println("Disconnect:   "+ webSocketMessageBrokerStats.getWebSocketSessionStatsInfo());
    }
}
