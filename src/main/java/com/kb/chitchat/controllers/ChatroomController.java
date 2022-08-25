package com.kb.chitchat.controllers;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.kb.chitchat.models.PublicChannel;
import com.kb.chitchat.models.PublicMessage;
import com.kb.chitchat.services.PublicChannelService;
import com.kb.chitchat.services.PublicMessageService;
import com.kb.chitchat.services.UserService;

@Controller
public class ChatroomController {
    @Autowired
    UserService userService;

    @Autowired
    PublicChannelService publicChannelService;

    @Autowired
    PublicMessageService publicMessageService;

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
        
        List<PublicChannel> channels = publicChannelService.allPublicChannels();
        HashMap<PublicChannel, List<PublicMessage>> channelMap = new HashMap<PublicChannel, List<PublicMessage>>();
        
        for (int i = 0; i < channels.size(); i++) {
            List<PublicMessage> messages = publicMessageService
                    .find10RecentPublicChannelMessages(channels.get(i).getId());
            Collections.reverse(messages);
            channelMap.put(channels.get(i), messages);
        }
<<<<<<< HEAD
        
        
=======
>>>>>>> caa441f006e5d5a1a381fdccb7cffe10e9030668
        model.addAttribute("channelMap", channelMap);

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
        // ! TODO: this does not work for private chat yet, we might redirect them to diffrent route, it will crash the server.
        PublicChannel channel = publicChannelService.findPublicChannelByName((String)session.getAttribute("chatroomName"));
        model.addAttribute("channelId", channel.getId());
        model.addAttribute("channel", channel);

        // Recent 50 messages
        List<PublicMessage> messages = publicMessageService.find50RecentPublicChannelMessages(channel.getId());
        Collections.reverse(messages);
        // System.out.println("messages:" + messages);
        model.addAttribute("messages", messages);
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
    public String chatroomEnter(@RequestParam("chatroomName") String chatroomName, HttpSession session) {
        session.setAttribute("chatroomName", chatroomName);
        return "redirect:/chatrooms/" + chatroomName;
    }


    @PostMapping("/channels/new")
    public String createChannel(@Valid @ModelAttribute("channel") PublicChannel channel,
            BindingResult result, Model model, HttpSession session, @RequestParam("privacySwitch") String privacySwitch) {

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
        
        if (privacySwitch.equals(",0")) {
        	channel.setIsPublic("0");
        }
        
        System.out.println(channel.getIsPublic());
        
        publicChannelService.savePublicChannel(channel);
        return "redirect:/users/chatrooms";

    }

    // ! Edit =================================================================
    // ! Edit publicchannel page
    @GetMapping("/channels/{name}/edit")
    public String editPublicChannel(@PathVariable("name") String name, Model model, HttpSession session) {
    	// validation for logged in user
    	Long userId = (Long) session.getAttribute("id");   
    	Long publicchannelUserId = publicChannelService.findPublicChannelByName(name).getCreator().getId();
    	
    	// put user back if not logged in
    	if (userId == null) {
    		return "redirect:/";
    	} 
    	
    	if (!userId.equals(publicchannelUserId)) {
    		return "redirect:/";
    	}
    	
    	model.addAttribute("channel", publicChannelService.findPublicChannelByName(name));
    	return "views/editPublicChannel.jsp";

    }
    
    
    // Edit put request
    @RequestMapping(value="/channels/{id}", method=RequestMethod.PUT)
    public String updatePublicChannel(@Valid @ModelAttribute("channel") PublicChannel channel, BindingResult result, 
    		@PathVariable("id") Long id,  @RequestParam("privacySwitch") String privacySwitch) {
    	

        PublicChannel channelTemp = publicChannelService.findPublicChannelByName(channel.getChannelName());
        if (channelTemp != null && channelTemp.getId() != channel.getId()) {
            // not unique
            result.rejectValue("channelName", "nonUnique", "Name is taken, please try again");
        }

        if (result.hasErrors()) {
            return  "views/editPublicChannel.jsp";
        } else {
              
            if (privacySwitch.equals(",0")) {
                channel.setIsPublic("0");
            }
            publicChannelService.savePublicChannel(channel);
            return "redirect:/users/chatrooms";
        }
        
        
        
    }
    
    
    // Delete Route ============================================================
    // basic delete
    @RequestMapping(value="/channels/{id}", method=RequestMethod.DELETE)
    public String deletePublicChannel(@PathVariable("id") Long id) {
    	publicChannelService.deletePublicChannel(publicChannelService.findPublicChannel(id));
    	return "redirect:/users/chatrooms";
    }
    






}
