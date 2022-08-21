package com.kb.chitchat.models;

import java.util.List;

public class UserInfo {
    private Long id;
    private String username;
    private String nickname;
    private List<String> channels;
    
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getNickname() {
        return nickname;
    }
    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
    public List<String> getChannels() {
        return channels;
    }
    public void setChannels(List<String> channels) {
        this.channels = channels;
    }

    
    
    
}
