package com.kb.chitchat.services;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.kb.chitchat.models.LoginUser;
import com.kb.chitchat.models.User;
import com.kb.chitchat.repositories.UserRepository;

@Service
public class UserService {
	
	@Autowired
	UserRepository userRepository;
	
	public User register(User newUser, BindingResult result) {
		
		if(userRepository.findByEmailIs(newUser.getEmail())!=null) 
			result.rejectValue("email", "Exists", "Email belongs to an account");
		if(!(newUser.getPassword().equals(newUser.getConfirm()))) 
			result.rejectValue("confirm", "Matches", "Confirm does not match");
			
		if (result.hasErrors())
			return null;
		
		String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
		newUser.setPassword(hashed);
		return userRepository.save(newUser);
	}
	
	public User login(LoginUser newLoginObject, BindingResult result) {

		if(userRepository.findByEmailIs(newLoginObject.getEmail())==null) {
			result.rejectValue("email", "Not Present", "Email not present");
			return null;
		}
			
		User user = userRepository.findByEmailIs(newLoginObject.getEmail());
			
		if(!BCrypt.checkpw(newLoginObject.getPassword(), user.getPassword())) {
			result.rejectValue("password", "Matches", "Invalid password");
			return null;
		}
		return user;
	}	
	
	public User findUserById(Long id) {
		return userRepository.findByIdIs(id);
    }
}

