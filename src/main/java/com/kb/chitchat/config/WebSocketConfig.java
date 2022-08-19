package com.kb.chitchat.config;


import javax.annotation.PostConstruct;
import org.springframework.context.annotation.Configuration;

import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.*;

// configures the websocket
@Configuration
@EnableWebSocketMessageBroker // this enables to use WebSocket server
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    // configure the webSocketMessageBrokerStat;
	// you might not able to have this b/c of circular imports
//    @Autowired
//    private WebSocketMessageBrokerStats webSocketMessageBrokerStats;

    @PostConstruct
    public void init() {
        // log every 5000 milliseconds
        // webSocketMessageBrokerStats.setLoggingPeriod(10000);
    }

    // we are implementing  WebSocketMessageBrokerConfigurer, the default methond
    @Override
    // Simple (or Streaming) Text Oriented Message Protocol (STOMP), formerly known as TTMP, is a simple text-based protocol, designed for working with message-oriented middleware (MOM).
    // we register a websocket endpoint that the clients will use to connect to our websocket server.
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        // client can have access to /ws endpoint
        registry.addEndpoint("/ws").withSockJS();

        // WebSocketMessageBrokerStats stats = new WebSocketMessageBrokerStats();
        // // set loggin status to every 3000 milliseconds
        // stats.setLoggingPeriod(1);
    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        // defines that the messages whose destination starts with “/app” should be routed to message-handling methods in controller
        registry.setApplicationDestinationPrefixes("/app");
        // “/topic” should be routed to the message broker
        registry.enableSimpleBroker("/topic");   // Enables a simple in-memory broker


        //   Use this for enabling a Full featured broker like RabbitMQ

        /*
        registry.enableStompBrokerRelay("/topic")
                .setRelayHost("localhost")
                .setRelayPort(61613)
                .setClientLogin("guest")
                .setClientPasscode("guest");
        */
    }



}
