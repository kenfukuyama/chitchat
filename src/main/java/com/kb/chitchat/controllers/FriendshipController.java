package com.kb.chitchat.controllers;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

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
import com.kb.chitchat.models.PrivateMessage;
import com.kb.chitchat.models.User;
import com.kb.chitchat.services.FriendshipService;
import com.kb.chitchat.services.PrivateMessageService;
import com.kb.chitchat.services.UserService;

@Controller
public class FriendshipController {

    @Autowired
    UserService userService;

    @Autowired
    FriendshipService friendshipService;

    @Autowired
    PrivateMessageService privateMessageService;

    private static final Logger logger = LoggerFactory.getLogger(FriendshipController.class);

    @GetMapping("/users/friends")
    public String friendsPage(Model model, HttpSession session) {
        model.addAttribute("loggedInUser", userService.findUserById((Long) session.getAttribute("id")));
        // # all users
        model.addAttribute("users", userService.allRegisteredUsers());
        

        // # all friends
        // List<Friendship> approvedFriendships = friendshipService.allFriendshipsByUserId((Long) session.getAttribute("id"));
        List<Friendship> approvedFriendships = friendshipService.allApprovedFriendshipsByUserId((Long) session.getAttribute("id"));
        model.addAttribute("approvedFriendships", approvedFriendships);
        // System.out.println("approvedFriendships: " + approvedFriendships);
        List<User> approvedFriends = new ArrayList<User>();
        for (Friendship approvedFriendship : approvedFriendships ) {
            if (approvedFriendship.getUser().getId().equals((Long) session.getAttribute("id"))) {
                approvedFriends.add(userService.findUser(approvedFriendship.getFriend().getId()));
            }
            else {
                approvedFriends.add(userService.findUser(approvedFriendship.getUser().getId()));
            }
        }
        model.addAttribute("approvedFriends", approvedFriends);
        // System.out.println(approvedFriends);

        // find all pending friends
        // List<Friendship> approvedFriendships = friendshipService.allFriendshipsByUserId((Long) session.getAttribute("id"));
        List<Friendship> pendingFriendships = friendshipService.allPendingFriendshipsByUserId((Long) session.getAttribute("id"));
        model.addAttribute("pendingFriendships", pendingFriendships);
        // List<User> pendingFriends = new ArrayList<User>();
        // for (Friendship pendingFriendship : pendingFriendships ) {
        //     if (pendingFriendship.getUser().getId() == (Long) session.getAttribute("id")) {
        //         pendingFriends.add(userService.findUser(pendingFriendship.getFriend().getId()));
        //     }
        //     else {
        //         pendingFriends.add(userService.findUser(pendingFriendship.getUser().getId()));
        //     }
        // }
        return "views/friends.jsp";

    }

    @PostMapping("/users/pendingConnect")
    public String pendingConnect(@RequestParam("loggedInUserId") Long loggedInUserId,
    @RequestParam("userId") Long userId) {
        Friendship friendship = new Friendship();
        friendship.setUser(userService.findUser(loggedInUserId));
        friendship.setFriend(userService.findUser(userId));
        friendship.setName(loggedInUserId + "_" + userId);
        friendship.setNickname(loggedInUserId + "_" + userId);
        friendship.setApproved(0);
        
        friendshipService.saveFriendship(friendship);
        
    	return "redirect:/users/friends";
    }
    
    @PostMapping("/users/approveConnect")
    public String approveConnect(@RequestParam("loggedInUserId") Long loggedInUserId,
    						 @RequestParam("userId") Long userId) {
    	Friendship friendship = friendshipService.findFriendshipBidirectional(loggedInUserId, userId);
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
    public String chatroomPrivateEnter(@RequestParam("loggedInUserId") Long loggedInUserId,  @RequestParam("userId") Long userId, HttpSession session) {
        // // TODO: refactor this so it finds the frineds quickly without two lines
        // Friendship friending = friendshipService.findFriendship(loggedInUserId, userId);
        // Friendship friended = friendshipService.findFriendship(userId, loggedInUserId);

        // if (friending != null) {
        //     session.setAttribute("chatroomName", friending.getName());
        //     return "redirect:/chatrooms/" + friending.getName();
        // }
        // else if (friended != null) {
        //     session.setAttribute("chatroomName", friended.getName());
        //     return "redirect:/chatrooms/" + friended.getName();
        // }
        // else {
        //     logger.info("No friendship found but tried to chat");
        //     return "redirect:/chatrooms/" + "nowhere";
        // }

        // System.out.println("loggedInUserId: " + loggedInUserId);
        // System.out.println("userId: " + userId);

        Friendship friendship = friendshipService.findFriendshipBidirectional(loggedInUserId, userId);
        session.setAttribute("selectedFriendshipId", friendship.getId());
        return "redirect:/users/dashboard";
        
    }


    @GetMapping("/users/dashboard")
    public String userDashboard(Model model, HttpSession session) {
        // models for private messages later
        model.addAttribute("id", (Long)session.getAttribute("id"));
        model.addAttribute("username", (String)session.getAttribute("username"));
        model.addAttribute("nickname", (String)session.getAttribute("nickname"));

    	model.addAttribute("loggedInUser", userService.findUserById((Long) session.getAttribute("id")));
        // # all users
        model.addAttribute("users", userService.allRegisteredUsers());        

        // # all friends
        // List<Friendship> approvedFriendships = friendshipService.allFriendshipsByUserId((Long) session.getAttribute("id"));
        List<Friendship> approvedFriendships = friendshipService.allApprovedFriendshipsByUserId((Long) session.getAttribute("id"));
        model.addAttribute("approvedFriendships", approvedFriendships);
        // System.out.println("approvedFriendships: " + approvedFriendships);

        List<User> approvedFriends = new ArrayList<User>();
        for (Friendship approvedFriendship : approvedFriendships ) {
            if (approvedFriendship.getUser().getId().equals((Long) session.getAttribute("id"))) {
                // System.out.println("you friended them");
                approvedFriends.add(userService.findUser(approvedFriendship.getFriend().getId()));
            }
            else {
                // System.out.println("they friended you");
                approvedFriends.add(userService.findUser(approvedFriendship.getUser().getId()));
            }
        }
        model.addAttribute("approvedFriends", approvedFriends);
        // System.out.println(approvedFriends);

        // first messages of all approvedFriendships
        // int approvedFriendshipsSize = approvedFriendships.size();
        // int[] approvedFriendshipsSizeArr = new int[approvedFriendshipsSize];
        // for (int i = 0; i < approvedFriendshipsSize; i++) { approvedFriendshipsSizeArr[i] = i;}


        List<PrivateMessage> recentMessages = new ArrayList<PrivateMessage>();
        
        for (int i = 0; i < approvedFriendships.size(); i++) {
            if (privateMessageService.findMostRecentMessages(approvedFriendships.get(i).getId()) != null) {
                recentMessages.add(privateMessageService.findMostRecentMessages(approvedFriendships.get(i).getId()));
                // recentMessagesIdx.add(i);
            }
        }

        // for (PrivateMessage message : recentMessages) {
        //     if (message != null) {
        //         System.out.println(message.getContent()+ " " + message.getCreatedAt());
        //     }
        //     else {
        //         System.out.println("no recent messages");
        //     }
        // }
        // System.out.println(recentMessages);
        Collections.sort(recentMessages, Collections.reverseOrder());
        // System.out.println("After sort=================================");


        List<User> friendsWithMessages = new ArrayList<User>();

        
        for (PrivateMessage message : recentMessages) {
            if (message != null) {
                // System.out.println(message.getContent()+ " " + message.getCreatedAt());
                // System.out.println(message.getFriendship().getFriend().getNickname() + " " + message.getFriendship().getUser().getNickname());
                if (message.getFriendship().getUser().getId().equals((Long) session.getAttribute("id"))) {
                    // System.out.println("you friended them");
                    friendsWithMessages.add(userService.findUser(message.getFriendship().getFriend().getId()));
                }
                else {
                    // System.out.println("they friended you");
                    friendsWithMessages.add(userService.findUser(message.getFriendship().getUser().getId()));
                }
            }
            else {
                System.out.println("no recent messages");
            }
        }

        int friendsWithMessagesSize = friendsWithMessages.size();
        int[] friendsWithMessagesSizeArr = new int[friendsWithMessagesSize];
        for (int i = 0; i < friendsWithMessagesSize; i++) { friendsWithMessagesSizeArr[i] = i;}

        // System.out.println("friends with messages: ");
        // for (User user : friendsWithMessages) {
        //     System.out.println(user.getNickname());
        // }

        List<User> friendWithOutMessages = new ArrayList<User>();
        for (User friend : approvedFriends) {
            if (!friendsWithMessages.contains(friend)) {
                friendWithOutMessages.add(friend);
            }
        }
        
        // System.out.println("friends without messages: ");
        // for (User user : friendWithOutMessages) {
        //     System.out.println(user.getNickname());
        // }


        // ======================================================
        // System.out.println("=================================================");
        // System.out.println("friends with messages: ");
        // for (User user : friendsWithMessages) {
        //     System.out.println(user.getNickname());
        // }

        // // for (int i : friendsWithMessagesSizeArr) {
        // //     System.out.println(i);
        // // }

        // for (int i = 0; i < friendsWithMessagesSizeArr.length; i++) {
        //     System.out.println(friendsWithMessagesSizeArr[i]);
        // }

        // for (PrivateMessage message : recentMessages) {
        //     if (message != null) {
        //         System.out.println(message.getContent()+ " " + message.getCreatedAt());
        //     }
        //     else {
        //         System.out.println("no recent messages");
        //     }
        // }

                
        // System.out.println("friends without messages: ");
        // for (User user : friendWithOutMessages) {
        //     System.out.println(user.getNickname());
        // }

        model.addAttribute("friendsWithMessagesSizeArr", friendsWithMessagesSizeArr);
        model.addAttribute("friendsWithMessages", friendsWithMessages);
        model.addAttribute("recentMessages", recentMessages);
        model.addAttribute("friendWithOutMessages", friendWithOutMessages);

        // ArrayList<PrivateMessage> recentMessagesSorted = recentMessages;
        // recentMessagesSorted.sort(recentMessagesSorted);

        // ! TODO: friendship if it selected otherwise set to person with the most recent message
        // ! if not friends  or if there is not recent message  show something eles
        if (session.getAttribute("selectedFriendshipId") != null) {
            Friendship selectedFriendship = friendshipService.findFriendship((Long) session.getAttribute("selectedFriendshipId"));
            model.addAttribute("selectedFriendship", selectedFriendship);
            List<PrivateMessage> messages = privateMessageService.find50RecentMessages(selectedFriendship.getId());
            Collections.reverse(messages);
            model.addAttribute("messages", messages);
            // System.out.println("frieshdp selected");
        }
        else {

            System.out.println("no friendship selected");
        }

        
        return "views/dashboard.jsp";
    }



}
