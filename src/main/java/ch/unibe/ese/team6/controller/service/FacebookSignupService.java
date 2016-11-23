package ch.unibe.ese.team6.controller.service;

import java.security.SecureRandom;
import java.math.BigInteger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ch.unibe.ese.team6.controller.pojos.forms.FacebookLoginForm;
import ch.unibe.ese.team6.controller.pojos.forms.GoogleSignupForm;
import ch.unibe.ese.team6.model.User;
import ch.unibe.ese.team6.model.KindOfMembership;
import ch.unibe.ese.team6.model.Gender;
import ch.unibe.ese.team6.model.dao.UserDao;

/** Handles the persisting of new users signing up with google */
@Service
public class FacebookSignupService {
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private MessageService messageService;

	/** Handles persisting a new user to the database. */
	@Transactional
	public void saveFrom(FacebookLoginForm facebookForm) {
		User user = new User();
		user.setUsername(facebookForm.getEmail());
		user.setEmail(facebookForm.getEmail());
		user.setFirstName(facebookForm.getFirstName());
		user.setLastName(facebookForm.getLastName());
		
		final SecureRandom rndm = new SecureRandom();
		String randomPassword = new BigInteger(50, rndm).toString(32);
		user.setPassword(randomPassword); //sets a strong random password
		
		user.setEnabled(true);
		user.setGender(Gender.OTHER);
		user.setIsGoogleUser(true);
		
		user.setKindOfMembership(KindOfMembership.NORMAL);
		
		userDao.save(user);
		
		String tex = "Thanks for signing up at EstateArranger. Here is your new Password: " + randomPassword;
		String sub = "EstateArranger!";
		messageService.sendEmail(user, sub, tex);
	}
	
	/**
	 * Returns whether a user with the given username already exists.
	 * @param username the username to check for
	 * @return true if the user already exists, false otherwise
	 */
	@Transactional
	public boolean doesUserWithUsernameExist(String username){
		return userDao.findByUsername(username) != null;
	}
}
