package com.kb.chitchat.models;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

public class LoginUser {

	@NotEmpty(message="Please enter an email")
	@Email(message="Email invalid")
	private String email;
	
	@NotEmpty(message="Please enter password")
	@Size(min=8, max=255, message="Password must be at least 8 characters")
	private String password;
	
	public LoginUser() {
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
	
	
}
