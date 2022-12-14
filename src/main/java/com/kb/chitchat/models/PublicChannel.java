package com.kb.chitchat.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="pubic_channels")
public class PublicChannel {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

	@NotNull
    @Size(min=2, max=50, message="Channel Name must be 2 to 50 characters")
	private String channelName;

    @NotNull
    @Size(min=2, max=50, message="Channel Nickname must be 2 to 50 characters")
	private String channelNickname;

    private String isPublic;

    @Size(min=30, max=100, message="Channel Nickname must be 30 to 100 characters")
    private String description;


    // ! relationships
    // its self to keep track to creator
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="creator_id")
    private User creator;

    // public messages
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "public_messages", 
        joinColumns = @JoinColumn(name = "public_channel_id"), 
        inverseJoinColumns = @JoinColumn(name = "user_id")
    )
    private List<User> senders;

    @Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createdAt;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updatedAt;
    
    @PrePersist
    protected void onCreate(){
    	this.createdAt = new Date();
    }
    
    @PreUpdate
    protected void onUpdate(){
    	this.updatedAt = new Date();
    }

    public PublicChannel() {}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

    public Date getCreatedAt() {
        return this.createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return this.updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public User getCreator() {
        return this.creator;
    }

    public void setCreator(User creator) {
        this.creator = creator;
    }


    public String getChannelName() {
        return this.channelName;
    }

    public void setChannelName(String channelName) {
        this.channelName = channelName;
    }

    public String getChannelNickname() {
        return this.channelNickname;
    }

    public void setChannelNickname(String channelNickname) {
        this.channelNickname = channelNickname;
    }

    public String getIsPublic() {
        return this.isPublic;
    }

    public void setIsPublic(String isPublic) {
        this.isPublic = isPublic;
    }


    public List<User> getSenders() {
        return this.senders;
    }

    public void setSenders(List<User> senders) {
        this.senders = senders;
    }


    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }


}
