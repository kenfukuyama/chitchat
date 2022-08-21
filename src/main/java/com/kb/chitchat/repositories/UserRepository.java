package com.kb.chitchat.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.kb.chitchat.models.User;

public interface UserRepository extends CrudRepository<User, Long> {
	List<User> findAll();
	List<User> findByRegistered(Integer registered);
	User findByEmailIs(String email);
	User findByIdIs(Long id);
	User findByUsername(String username);
}