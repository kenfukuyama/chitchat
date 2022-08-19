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
    // ! Render(Get) pages
    // guest page
    @GetMapping("/guests/new")
    public String newGuestPage() {
        return "/views/guest.jsp";
    }

    // chatrooms page
    @GetMapping("/chatrooms")
    public String chatroomsPage(Model model, HttpSession session) {
        model.addAttribute("userName", (String)session.getAttribute("userName"));
        return "views/chatrooms.jsp";
    }

    // individual chatrooms page
    @GetMapping("/chatrooms/{chatroomName}") 
    public String chatroomPage(@PathVariable("chatroomName") String chatroomName, 
                                HttpSession session,
                                Model model) {
        model.addAttribute("userName", (String)session.getAttribute("userName"));
        model.addAttribute("chatroomName",  (String)session.getAttribute("chatroomName"));
        System.out.println("entering:" + chatroomName);
        System.out.println(model.getAttribute("userName"));
        return "views/chatroom.jsp";
    } 

    // ! Post Methods
    // create new guest
    @PostMapping("/guests/new") 
    public String guestSignup(@RequestParam("userId") String userId, 
                            @RequestParam("userName") String userName,
                            HttpSession session) {

        session.setAttribute("userId", userId);
        session.setAttribute("userName", userName);
        System.out.println("userId: " + userId);
        System.out.println("userName: " + userName);

        return "redirect:/chatrooms";
    }

    @PostMapping("/chatrooms/enter") 
    public String guestSignup(@RequestParam("chatroomName") String chatroomName, HttpSession session) {
        session.setAttribute("chatroomName", chatroomName);
        System.out.println("posting chatroomName: " + chatroomName);
        return "redirect:/chatrooms/" + chatroomName;
    }






}
