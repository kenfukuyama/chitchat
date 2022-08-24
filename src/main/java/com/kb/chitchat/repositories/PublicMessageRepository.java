package com.kb.chitchat.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.kb.chitchat.models.PublicMessage;

public interface PublicMessageRepository extends CrudRepository<PublicMessage, Long> {
	List<PublicMessage> findAll();
	List<PublicMessage> findByPublicChannelId(Long public_channel_id);

	@Query(value = "SELECT * FROM schema_chitchat.public_messages WHERE public_channel_id = ?1 ORDER BY created_at DESC LIMIT 50;", nativeQuery = true)
	Optional<List<PublicMessage>> findRecent50MessagesByChannelId(Long channedlId);
}