package com.kb.chitchat.controllers;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kb.chitchat.models.LoginUser;
import com.kb.chitchat.models.User;

public class UserController {
	@GetMapping("/register")
	public String register(Model model) {
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoginUser());
		return "/views/login.jsp";
	}
	
	@GetMapping("/login")
	public String login(Model model) {
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoginUser());
		return "/views/login.jsp";
	}
}
