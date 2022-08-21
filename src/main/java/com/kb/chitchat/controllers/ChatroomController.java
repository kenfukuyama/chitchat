package com.kb.chitchat.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ChatroomController {

    // ! Get Pages
    // chatrooms page
    @GetMapping("/chatrooms")
    public String chatroomsPage(Model model, HttpSession session) {
        // check for logged in
        if (session.getAttribute("id") == null) {
            return "redirect:/";
        }
        model.addAttribute("id", session.getAttribute("id"));
        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("nickname", session.getAttribute("nickname"));
        return "views/chatrooms.jsp";
    }

    // individual chatrooms page
    @GetMapping("/chatrooms/{chatroomName}") 
    public String chatroomPage(@PathVariable("chatroomName") String chatroomName, 
                                HttpSession session,
                                Model model) {
        // check for logged in
        if (session.getAttribute("id") == null) {
            return "redirect:/";
        }
        model.addAttribute("id", session.getAttribute("id"));
        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("nickname", session.getAttribute("nickname"));
        model.addAttribute("chatroomName", session.getAttribute("chatroomName"));
        return "views/chatroom.jsp";
    } 

    // ! Post Methods
    @PostMapping("/chatrooms/enter") 
    public String guestSignup(@RequestParam("chatroomName") String chatroomName, HttpSession session) {
        session.setAttribute("chatroomName", chatroomName);
        return "redirect:/chatrooms/" + chatroomName;
    }






}
