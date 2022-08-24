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
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "users")
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Size(min = 3, max = 30, message = "Must be 3 to 30 characters")
	private String username;

	@Size(min = 2, max = 30, message = "Must be 2 to 30 characters")
	private String nickname;

	// @NotEmpty(message="Email is required")
	// @Email(message="Please enter a valid email")
	private String email;

	// @Size(min=8, max=128, message="Must be 8 to 128 characters")
	private String password;

	@NotNull
	private Integer registered;

	@Transient
	private String confirm;

	@Column(updatable = false)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date createdAt;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updatedAt;

	@PrePersist
	protected void onCreate() {
		this.createdAt = new Date();
	}

	@PreUpdate
	protected void onUpdate() {
		this.updatedAt = new Date();
	}

	// ! relationships
	// channel created
	@OneToMany(mappedBy = "creator", fetch = FetchType.LAZY)
	private List<PublicChannel> createdChannels;

	// friendships
	@ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "friendships", 
        joinColumns = @JoinColumn(name = "user_id"), 
        inverseJoinColumns = @JoinColumn(name = "friend_id")
    )
    private List<User> friendingUsers;
    
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "friendships", 
        joinColumns = @JoinColumn(name = "friend_id"), 
        inverseJoinColumns = @JoinColumn(name = "user_id")
    )
    private List<User> friendedUsers;


	// public message
	@ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "public_messages", 
        joinColumns = @JoinColumn(name = "user_id"), 
        inverseJoinColumns = @JoinColumn(name = "public_channel_id")
    )
    private List<PublicChannel> publicChannels;

	public User() {
	}

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
		return this.nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConfirm() {
		return confirm;
	}

	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}


	public Integer getRegistered() {
		return this.registered;
	}

	public void setRegistered(Integer registered) {
		this.registered = registered;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public List<PublicChannel> getCreatedChannels() {
		return this.createdChannels;
	}

	public void setCreatedChannels(List<PublicChannel> createdChannels) {
		this.createdChannels = createdChannels;
	}


	public List<User> getFriendingUsers() {
		return this.friendingUsers;
	}

	public void setFriendingUsers(List<User> friendingUsers) {
		this.friendingUsers = friendingUsers;
	}

	public List<User> getFriendedUsers() {
		return this.friendedUsers;
	}

	public void setFriendedUsers(List<User> friendedUsers) {
		this.friendedUsers = friendedUsers;
	}


	public List<PublicChannel> getPublicChannels() {
		return this.publicChannels;
	}

	public void setPublicChannels(List<PublicChannel> publicChannels) {
		this.publicChannels = publicChannels;
	}

}
