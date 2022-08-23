package com.kb.chitchat.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.kb.chitchat.models.Friendship;

public interface FriendshipRepository extends CrudRepository<Friendship, Long> {
	List<Friendship> findAll();
	Friendship findByUserIdAndFriendId(Long userId, Long friendId);
	List<Friendship> findAllByUserId(Long userId);
}