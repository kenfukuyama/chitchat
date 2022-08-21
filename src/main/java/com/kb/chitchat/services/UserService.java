package com.kb.chitchat.services;

import java.util.List;
import java.util.Optional;
import java.util.regex.Pattern;

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
		
		if(userRepository.findByUsername(newUser.getUsername()) != null)
			result.rejectValue("username", "Exists", "Username is taken, please try again");
		if (!isValidEmail(newUser.getEmail())) 
			result.rejectValue("email", "Email is not valid", "Email is not valid");
		if(userRepository.findByEmailIs(newUser.getEmail())!=null) 
			result.rejectValue("email", "Exists", "Email belongs to an account");
		if(newUser.getPassword().length() < 8)
			// TODO check for stronger password
			result.rejectValue("password", "Weak", "Password needs to be at least 8 characters");
		if(!(newUser.getPassword().equals(newUser.getConfirm()))) 
			result.rejectValue("confirm", "Matches", "Confirm Password does not match");
			
		if (result.hasErrors())
			return null;
		
		String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
		newUser.setPassword(hashed);
		return userRepository.save(newUser);
	}
	
	public User registerGuest(User newUser, BindingResult result) {
		if(userRepository.findByUsername(newUser.getUsername()) != null)
			result.rejectValue("username", "Exists", "Username is taken, please try again");
			
		if (result.hasErrors())
			return null;
		
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

	public boolean isValidEmail(String email) {
		String emailRegex = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";
		return Pattern.compile(emailRegex).matcher(email).matches();
	}

	// CRUD
	// read all
	public List<User> allUsers(){ 
		return userRepository.findAll();
	}

	// read all registered users
	public List<User> allRegisteredUsers(){ 
		return userRepository.findByRegistered(1);
	}

	
	
	// Create and Update
	public User saveUser(User user) {
		return userRepository.save(user);
	}
	
	// delete
	public void deleteUser(User user) {
		userRepository.delete(user);
	}
	
	// read one
	public User findUser(Long id) {
		Optional<User> optionalUser = userRepository.findById(id);
		
		if (optionalUser.isPresent()) { return optionalUser.get(); } 
		else { return null;}
	}


	// // many to many relationship service
	// public User addConnect(Long loggedInUserId, Long userId) {
	// 	// retrieve an instance of a user using another method in the service.
	// 	User thisUser = findUser(loggedInUserId);
	// 	User OtherUser = findUser(userId);
	// 	// add the user to this user's list of users
	// 	thisUser.getFriendedUsers().add(OtherUser);

	// 	// Save thisUser, since you made changes to its user list.
	// 	return userRepository.save(thisUser);

	// }

	// public User removeConnect(Long userId, Long userId) {
	// 	// retrieve an instance of a user using another method in the service.
	// 	User thisUser = findUser(userId);
	// 	User thisUser = userService.findUser(userId);
	// 	// add the user to this user's list of users
	// 	thisUser.getUpvotedUsers().remove(thisUser);

	// 	// Save thisUser, since you made changes to its user list.
	// 	// TODO: don't forget this!!
	// 	return userRepo.save(thisUser);

	// }
}

