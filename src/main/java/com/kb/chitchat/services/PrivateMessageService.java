package com.kb.chitchat.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kb.chitchat.models.PrivateMessage;
import com.kb.chitchat.repositories.PrivateMessageRepository;


@Service
public class PrivateMessageService {
	@Autowired 
	private PrivateMessageRepository privateMessageRepository;

	// for many to many
	// @Autowired
	// private UserService userService;
	
		
	// read all
	public List<PrivateMessage> allPrivateMessages(){ 
		return privateMessageRepository.findAll();
	}
	
	// Create and Update
	public PrivateMessage savePrivateMessage(PrivateMessage privatemessage) {
		return privateMessageRepository.save(privatemessage);
	}
	
	// delete
	public void deletePrivateMessage(PrivateMessage privatemessage) {
		privateMessageRepository.delete(privatemessage);
	}
	
	// read one
	public PrivateMessage findPrivateMessage(Long id) {
		Optional<PrivateMessage> optionalPrivateMessage = privateMessageRepository.findById(id);
		
		if (optionalPrivateMessage.isPresent()) { return optionalPrivateMessage.get(); } 
		else { return null;}
	}

	// read recent 50 by public channel id
	public List<PrivateMessage> find50RecentMessages(Long friendshipId) {
		Optional<List<PrivateMessage>> optionalPrivateMessages = privateMessageRepository.findRecent50MessagesByFriendshipId(friendshipId);
		if (optionalPrivateMessages.isPresent()) { return optionalPrivateMessages.get(); } 
		else { System.out.println("null"); return null;}
	}


	// read recent 50 by public channel id
	public PrivateMessage findMostRecentMessages(Long friendshipId) {
		Optional<List<PrivateMessage>> optionalPrivateMessages = privateMessageRepository.findMostRecentMessageByFriendshipId(friendshipId);
		if (optionalPrivateMessages.isPresent()) { 
			List<PrivateMessage> messages = optionalPrivateMessages.get();

			return (messages.size() > 0) ? messages.get(0) : null;
		}
		else { System.out.println("null"); return null;}
	}
}
