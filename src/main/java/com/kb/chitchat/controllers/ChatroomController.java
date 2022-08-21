package com.kb.chitchat.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kb.chitchat.models.PublicChannel;
import com.kb.chitchat.repositories.PublicChannelRepository;
import com.kb.chitchat.services.PublicChannelService;
import com.kb.chitchat.services.UserService;

@Controller
public class ChatroomController {

    @Autowired
    PublicChannelService publicChannelService;

    @Autowired
    UserService userService;

    // ! Get Pages
    // chatrooms page
    @GetMapping("/chatrooms")
    public String chatroomsPage(Model model, HttpSession session) {
        // check for logged in
        if (session.getAttribute("id") == null) {
            return "redirect:/";
        }
        model.addAttribute("id", (Long)session.getAttribute("id"));
        model.addAttribute("username", (String)session.getAttribute("username"));
        model.addAttribute("nickname", (String)session.getAttribute("nickname"));

        // Find the user
        model.addAttribute("user", userService.findUserById((Long)session.getAttribute("id")));
        // for channels
        model.addAttribute("publicChannels", publicChannelService.allPublicChannels());

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
        model.addAttribute("id", (Long)session.getAttribute("id"));
        model.addAttribute("username", (String)session.getAttribute("username"));
        model.addAttribute("nickname", (String)session.getAttribute("nickname"));
        model.addAttribute("chatroomName", (String)session.getAttribute("chatroomName"));
        return "views/chatroom.jsp";
    } 

    // registered users creating chatrooms
    @GetMapping("/users/chatrooms")
    public String chatroomCreatePage(@ModelAttribute("channel") PublicChannel channel, BindingResult result, 
                                    Model model, HttpSession session) {

        model.addAttribute("userId", (Long)session.getAttribute("id"));
        // TODO: change to the channels created by the users
        model.addAttribute("userChannels", publicChannelService.AllPublicChannelsByCreator((Long)session.getAttribute("id")));
        return "views/userChannels.jsp";

    }

    // ! Post Methods
    @PostMapping("/chatrooms/enter") 
    public String guestSignup(@RequestParam("chatroomName") String chatroomName, HttpSession session) {
        session.setAttribute("chatroomName", chatroomName);
        return "redirect:/chatrooms/" + chatroomName;
    }

    @PostMapping("/channels/new")
    public String createChannel(@Valid @ModelAttribute("channel") PublicChannel channel,
            BindingResult result, Model model, HttpSession session) {

        PublicChannel channelTemp = publicChannelService.findPublicChannelByName(channel.getChannelName());
        if (channelTemp != null) {
            // not unique
            result.rejectValue("channelName", "nonUnique", "Name is taken, please try again");
        }

        if (result.hasErrors()) {
            model.addAttribute("userId", (Long) session.getAttribute("id"));
            model.addAttribute("userChannels", publicChannelService.AllPublicChannelsByCreator((Long)session.getAttribute("id")));
            return "views/userChannels.jsp";
        }
        publicChannelService.savePublicChannel(channel);
        return "redirect:/users/chatrooms";

    }






}
