package com.kb.chitchat.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.kb.chitchat.models.PrivateMessage;

public interface PrivateMessageRepository extends CrudRepository<PrivateMessage, Long> {
	List<PrivateMessage> findAll();
	List<PrivateMessage> findByFriendshipId(Long friendshipId);


	@Query(value = "SELECT * FROM private_messages WHERE friendship_id = ?1 ORDER BY created_at DESC LIMIT 50;", nativeQuery = true)
	Optional<List<PrivateMessage>> findRecent50MessagesByFriendshipId(Long friendshipId);

	@Query(value = "SELECT * FROM private_messages WHERE friendship_id = ?1 ORDER BY created_at DESC LIMIT 1;", nativeQuery = true)
	Optional<List<PrivateMessage>> findMostRecentMessageByFriendshipId(Long friendshipId);
}