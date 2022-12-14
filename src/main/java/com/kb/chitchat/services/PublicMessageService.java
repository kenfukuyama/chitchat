package com.kb.chitchat.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kb.chitchat.models.PublicMessage;
import com.kb.chitchat.repositories.PublicMessageRepository;


@Service
public class PublicMessageService {
	@Autowired 
	private PublicMessageRepository publicmessageRepository;

	// for many to many
	// @Autowired
	// private UserService userService;
	
		
	// read all
	public List<PublicMessage> allPublicMessages(){ 
		return publicmessageRepository.findAll();
	}
	
	// Create and Update
	public PublicMessage savePublicMessage(PublicMessage publicmessage) {
		return publicmessageRepository.save(publicmessage);
	}
	
	// delete
	public void deletePublicMessage(PublicMessage publicmessage) {
		publicmessageRepository.delete(publicmessage);
	}
	
	// read one
	public PublicMessage findPublicMessage(Long id) {
		Optional<PublicMessage> optionalPublicMessage = publicmessageRepository.findById(id);
		
		if (optionalPublicMessage.isPresent()) { return optionalPublicMessage.get(); } 
		else { return null;}
	}

	// read recent 50 by public channel id
	public List<PublicMessage> find50RecentPublicChannelMessages(Long publicChannelId) {
		Optional<List<PublicMessage>> optionalPublicMessages = publicmessageRepository.findRecent50MessagesByChannelId(publicChannelId);
		if (optionalPublicMessages.isPresent()) { return optionalPublicMessages.get(); } 
		else { System.out.println("null"); return null;}
	}

	public List<PublicMessage> find10RecentPublicChannelMessages(Long publicChannelId) {
		Optional<List<PublicMessage>> optionalPublicMessages = publicmessageRepository.findRecent10MessagesByChannelId(publicChannelId);
		if (optionalPublicMessages.isPresent()) { return optionalPublicMessages.get(); } 
		else { System.out.println("null"); return null;}
	}

}
