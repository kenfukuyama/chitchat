package com.kb.chitchat.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
	@GetMapping("/")
	public String index(HttpSession session) {
		if (session.getAttribute("id") != null) {
			return "redirect:/chatrooms";
		}
		return "/views/index.jsp";
	}
	
	@GetMapping("/dashboard")
	public String dashboard() {
		return "/views/dashboard.jsp";
	}
	
}