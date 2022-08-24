package com.kb.chitchat.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.kb.chitchat.models.Friendship;

public interface FriendshipRepository extends CrudRepository<Friendship, Long> {
	List<Friendship> findAll();
	Friendship findByUserIdAndFriendId(Long userId, Long friendId);
	List<Friendship> findAllByUserId(Long userId);
	List<Friendship> findAllByFriendId(Long friendId);
	// Find all friendship of a user
	List<Friendship> findAllByUserIdOrFriendId(Long userId, Long frinedId);
	// Fina all aproved frinedship
	List<Friendship> findAllByApprovedAndUserIdOrFriendId(Integer approved, Long userId, Long frinedId);

	@Query(value = "SELECT * FROM friendships WHERE approved = 1 AND (user_id = ?1 OR friend_id = ?1);", nativeQuery = true)
	Optional<List<Friendship>> findApprovedFriendship(Long userId);

	@Query(value = "SELECT * FROM friendships WHERE approved = 0 AND (user_id = ?1 OR friend_id = ?1);", nativeQuery = true)
	Optional<List<Friendship>> findPendingFriendship(Long userId);

}