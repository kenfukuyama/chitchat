package com.kb.chitchat.repositories;

import java.util.Optional;

import org.springframework.data.repository.CrudRepository;

import com.kb.chitchat.models.User;

public interface UserRepository extends CrudRepository<User, Long> {
	Optional<User> findByEmail(String email);
}
