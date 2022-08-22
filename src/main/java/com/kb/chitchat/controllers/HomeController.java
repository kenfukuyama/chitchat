package com.kb.chitchat.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
	@GetMapping("/")
	public String index() {
		return "/views/index.jsp";
	}
	
	@GetMapping("/dashboard")
	public String dashboard() {
		return "/views/dashboard.jsp";
	}
	
}