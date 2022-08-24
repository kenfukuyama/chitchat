package com.kb.chitchat.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kb.chitchat.models.Friendship;
import com.kb.chitchat.repositories.FriendshipRepository;


@Service
public class FriendshipService {
	@Autowired 
	private FriendshipRepository friendshipRepository;

	private static final Logger logger = LoggerFactory.getLogger(FriendshipService.class);


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

	public Friendship findFriendshipBidirectional(Long userId, Long friendId) {
		Friendship friending = friendshipRepository.findByUserIdAndFriendId(userId, friendId);
        Friendship friended = friendshipRepository.findByUserIdAndFriendId(friendId, userId);

		Friendship friendship = (friending != null)? friending : friended;
		if (friendship != null) {
			return friendship;
		}
		else {
			logger.info("No friendship found but tried to get");
			return null;
		}
	}

	// find friendship in both directions
	public List<Friendship> allFriendshipsByUserId(Long userId){
		// List<Friendship> friendships = friendshipRepository.findAllByUserId(userId);
		// friendships.addAll(friendshipRepository.findAllByFriendId(userId));
		// return friendships;
		return friendshipRepository.findAllByUserIdOrFriendId(userId, userId);
	}

	// Find all approved friends
	// public List<Friendship> allApprovedFriendshipsByUserId(Long userId){
	// 	return friendshipRepository.findAllByApprovedAndUserIdOrFriendId(1, userId, userId);
	// }

	// Find all pending friends
	public List<Friendship> allPendingFriendshipsByUserId(Long userId){
		Optional<List<Friendship>> optionalFriendships = friendshipRepository.findPendingFriendship(userId);
		if (optionalFriendships.isPresent()) { return optionalFriendships.get(); } 
		else { System.out.println("null"); return new ArrayList<Friendship>();}
	}

	// Find all pending friends
	public List<Friendship> allApprovedFriendshipsByUserId(Long userId){
		Optional<List<Friendship>> optionalFriendships = friendshipRepository.findApprovedFriendship(userId);
		if (optionalFriendships.isPresent()) { return optionalFriendships.get(); } 
		else { System.out.println("null"); return new ArrayList<Friendship>();}
	}

}
