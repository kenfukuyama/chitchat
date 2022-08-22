package com.kb.chitchat.models;


public class ChatMessage {

    private MessageType type;
    private String content;
    private String sender;
    private String senderUsername;
    private String senderNickname;
    private int onlineNumber = -1;
    

    // these are custom data types
    public enum MessageType {
        CHAT,
        JOIN,
        LEAVE
    }
    
    // getters and setters
    public MessageType getType() {
        return type;
    }

    public void setType(MessageType type) {
        this.type = type;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getSenderUsername() {
        return this.senderUsername;
    }

    public void setSenderUsername(String senderUsername) {
        this.senderUsername = senderUsername;
    }

    public String getSenderNickname() {
        return this.senderNickname;
    }

    public void setSenderNickname(String senderNickname) {
        this.senderNickname = senderNickname;
    }

    public int getOnlineNumber() {
        return this.onlineNumber;
    }

    public void setOnlineNumber(int onlineNumber) {
        this.onlineNumber = onlineNumber;
    }

}
