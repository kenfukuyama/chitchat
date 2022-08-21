package com.kb.chitchat.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kb.chitchat.models.PublicChannel;
import com.kb.chitchat.repositories.PublicChannelRepository;


@Service
public class PublicChannelService {
	@Autowired 
	private PublicChannelRepository publicchannelRepository;

	// for many to many
	// @Autowired
	// private UserService userService;
	
		
	// read all
	public List<PublicChannel> allPublicChannels(){ 
		return publicchannelRepository.findAll();
	}

	
	// Create and Update
	public PublicChannel savePublicChannel(PublicChannel publicchannel) {
		return publicchannelRepository.save(publicchannel);
	}
	
	// delete
	public void deletePublicChannel(PublicChannel publicchannel) {
		publicchannelRepository.delete(publicchannel);
	}
	
	// read one
	public PublicChannel findPublicChannel(Long id) {
		Optional<PublicChannel> optionalPublicChannel = publicchannelRepository.findById(id);
		
		if (optionalPublicChannel.isPresent()) { return optionalPublicChannel.get(); } 
		else { return null;}
	}
	
	
	public PublicChannel findPublicChannelByName(String channelName) {
		Optional<PublicChannel> optionalPublicChannel = publicchannelRepository.findByChannelName(channelName);
		
		if (optionalPublicChannel.isPresent()) { return optionalPublicChannel.get(); } 
		else { return null;}
	}
	
	
	
	// // TODO: many to many relationship service
	// public PublicChannel addConnect(Long userId, Long publicchannelId) {
	// 	// retrieve an instance of a publicchannel using another method in the service.
	//     PublicChannel thisPublicChannel = findPublicChannel(publicchannelId);
	//     User thisUser = userService.findUser(userId);
	//     // add the user to this publicchannel's list of users
	//     thisPublicChannel.getUpvotedUsers().add(thisUser);
	    
	//     // Save thisPublicChannel, since you made changes to its user list.
	//     return publicchannelRepository.save(thisPublicChannel);
		
	// }
	
	
	// public PublicChannel removeConnect(Long userId, Long publicchannelId) {
	// 	// retrieve an instance of a publicchannel using another method in the service.
	//     PublicChannel thisPublicChannel = findPublicChannel(publicchannelId);
	//     User thisUser = userService.findUser(userId);
	//     // add the user to this publicchannel's list of users
	//     thisPublicChannel.getUpvotedUsers().remove(thisUser);
	    
	    
	//     // Save thisPublicChannel, since you made changes to its user list.
	//     // TODO: don't forget this!! 
	//     return publicchannelRepository.save(thisPublicChannel);
		
	// }
	
	// ! TODO addition validation
//	public void checkDate(PublicChannel publicchannel, BindingResult result) {
//		System.out.println(publicchannel.getPublicChannelDate());
//		System.out.println(new Date());
//		
//		if (publicchannel.getPublicChannelDate().after(new Date())) {
//			System.out.println("it is future");
//		}
//		else {
//			System.out.println("not futre");
//		}
//	}
//	
	
}
