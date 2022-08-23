package com.kb.chitchat.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kb.chitchat.models.Friendship;
import com.kb.chitchat.repositories.FriendshipRepository;


@Service
public class FriendshipService {
	@Autowired 
	private FriendshipRepository friendshipRepository;

	// for many to many
	// @Autowired
	// private UserService userService;
	
		
	// read all
	public List<Friendship> allFriendships(){ 
		return friendshipRepository.findAll();
	}
	
	// Create and Update
	public Friendship saveFriendship(Friendship friendship) {
		return friendshipRepository.save(friendship);
	}
	
	// delete
	public void deleteFriendship(Friendship friendship) {
		friendshipRepository.delete(friendship);
	}
	
	// read one
	public Friendship findFriendship(Long id) {
		Optional<Friendship> optionalFriendship = friendshipRepository.findById(id);
		
		if (optionalFriendship.isPresent()) { return optionalFriendship.get(); } 
		else { return null;}
	}


	public Friendship findFriendship(Long userId, Long friendId) {
		return friendshipRepository.findByUserIdAndFriendId(userId, friendId);
	}

	public List<Friendship> allFriendshipsByUserId(Long userId){
		return friendshipRepository.findAllByUserId(userId);
	}

}
