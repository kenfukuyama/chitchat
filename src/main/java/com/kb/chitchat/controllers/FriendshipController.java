package com.kb.chitchat.controllers;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kb.chitchat.models.Friendship;
import com.kb.chitchat.services.FriendshipService;
import com.kb.chitchat.services.UserService;

@Controller
public class FriendshipController {

    @Autowired
    UserService userService;

    @Autowired
    FriendshipService friendshipService;

    private static final Logger logger = LoggerFactory.getLogger(FriendshipController.class);

    @GetMapping("/users/friends")
    public String friendsPage(Model model, HttpSession session) {
        model.addAttribute("loggedInUser", userService.findUserById((Long) session.getAttribute("id")));
        model.addAttribute("users", userService.allRegisteredUsers());

        return "views/friends.jsp";

        
    }

    @PostMapping("/users/addConnect")
    public String addConnect(@RequestParam("loggedInUserId") Long loggedInUserId,
    						 @RequestParam("userId") Long userId) {
    	Friendship friendship = new Friendship();
        friendship.setUser(userService.findUser(loggedInUserId));
        friendship.setFriend(userService.findUser(userId));
        friendship.setName(loggedInUserId + "_" + userId);
        friendship.setNickname(loggedInUserId + "_" + userId);
        friendship.setApproved(1);

        friendshipService.saveFriendship(friendship);

    	return "redirect:/users/friends";
    }

    @PostMapping("/users/removeConnect")
    public String removeConnect(@RequestParam("loggedInUserId") Long loggedInUserId,
    						 @RequestParam("userId") Long userId) {

        // TODO: refactor this so it finds the frineds quickly without two lines
        Friendship friending = friendshipService.findFriendship(loggedInUserId, userId);
        Friendship friended = friendshipService.findFriendship(userId, loggedInUserId);

        if (friending != null) {
            friendshipService.deleteFriendship(friending);
        }
        else if (friended != null) {
            friendshipService.deleteFriendship(friended);
        }
        else {
            logger.info("No friendship found but tried to remove");
        }
    	return "redirect:/users/friends";
    }


    // Entering the private chat
    @PostMapping("/chatrooms/private/enter") 
    public String chatroomPrivateEnter(@RequestParam("loggedInUserId") Long loggedInUserId,  @RequestParam("userId") Long userId, HttpSession session, Model model) {
        System.out.println("loggedInUserId: " + loggedInUserId);
        System.out.println("userId: " + userId);

        // TODO: refactor this so it finds the frineds quickly without two lines
        Friendship friending = friendshipService.findFriendship(loggedInUserId, userId);
        Friendship friended = friendshipService.findFriendship(userId, loggedInUserId);

        if (friending != null) {
            session.setAttribute("chatroomName", friending.getName());
            return "redirect:/chatrooms/" + friending.getName();
        }
        else if (friended != null) {
            session.setAttribute("chatroomName", friended.getName());
            return "redirect:/chatrooms/" + friended.getName();
        }
        else {
            logger.info("No friendship found but tried to chat");
            return "redirect:/chatrooms/" + "nowhere";
        }
        
    }





}
