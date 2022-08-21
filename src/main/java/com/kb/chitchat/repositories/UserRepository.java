package com.kb.chitchat.repositories;

import org.springframework.data.repository.CrudRepository;

import com.kb.chitchat.models.User;

public interface UserRepository extends CrudRepository<User, Long> {
	User findByEmailIs(String email);
	User findByIdIs(Long id);
	User findByUsername(String username);
}