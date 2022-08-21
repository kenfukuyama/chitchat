package com.kb.chitchat.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.kb.chitchat.models.LoginUser;
import com.kb.chitchat.models.User;
import com.kb.chitchat.services.UserService;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	// ! For registered users ==========================================
	/******************************************************************/
	
	@GetMapping("/accounts/register")
	public String register(Model model) {
		model.addAttribute("newUser", new User());
		return "/views/register.jsp";
	}
	
	/******************************************************************/
	
	@GetMapping("/accounts/login")
	public String login(Model model) {
		model.addAttribute("newLogin", new LoginUser());
		return "/views/login.jsp";
	}
	
	/**********************************************************************/
	// Routes in case user tries mapping to login/register
	@GetMapping("/register")
	public String registerMapping(Model model) {
		model.addAttribute("newUser", new User());
		return "/views/register.jsp";
	}
	
	@GetMapping("/login")
	public String loginMapping(Model model) {
		model.addAttribute("newLogin", new LoginUser());
		return "/views/login.jsp";
	}
	/*********************************************************************/
	
	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User newUser,
			BindingResult result, Model model, HttpSession session) {

		User registerUser =  userService.register(newUser, result);
		
		if(result.hasErrors()) {
			return "/views/register.jsp";
		}
		else {
			session.setAttribute("id", registerUser.getId());
			session.setAttribute("username", registerUser.getUsername());
			session.setAttribute("nickname", registerUser.getNickname());
			return "redirect:/chatrooms";
		}
	}
	
	/******************************************************************/
	
	@PostMapping("/login")
	public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, 
			BindingResult result, Model model, HttpSession session) {
		
		User loginUser = userService.login(newLogin, result);
		
		if(result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "/views/login.jsp";
		}
		else {
			session.setAttribute("id", loginUser.getId());
			session.setAttribute("username", loginUser.getUsername());
			session.setAttribute("nickname", loginUser.getNickname());
			return "redirect:/chatrooms";
		}
	}
	
	/******************************************************************/
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}


	// ! For guest users ==========================================
    // guest page
    @GetMapping("/guests/new")
    public String newGuestPage(Model model) {
		model.addAttribute("newUser", new User());
        return "/views/guest.jsp";
    }

	// create new guest
	@PostMapping("/guests/new")
	public String guestSignup(@Valid @ModelAttribute("newUser") User newUser, BindingResult result,
	Model model, HttpSession session) {
	
		User guestUser = userService.registerGuest(newUser, result);

		if(result.hasErrors()) {
			return "/views/guest.jsp";
		}
		else {
			session.setAttribute("id", guestUser.getId());
			session.setAttribute("username", guestUser.getUsername());
			session.setAttribute("nickname", guestUser.getNickname());
			return "redirect:/chatrooms";
		}
	}
	
}
