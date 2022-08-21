package com.kb.chitchat.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;

import com.kb.chitchat.models.PublicChannel;

public interface PublicChannelRepository extends CrudRepository<PublicChannel, Long> {
	List<PublicChannel> findAll();
	Optional<PublicChannel> findByChannelName(String channelName);
	List<PublicChannel> findByCreatorId(Long creatorId);
}