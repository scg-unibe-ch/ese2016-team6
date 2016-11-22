package ch.unibe.ese.team6.controller.service;

import java.security.SecureRandom;
import java.math.BigInteger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ch.unibe.ese.team6.controller.pojos.forms.GoogleSignupForm;
import ch.unibe.ese.team6.model.User;
import ch.unibe.ese.team6.model.KindOfMembership;
import ch.unibe.ese.team6.model.Gender;
import ch.unibe.ese.team6.model.dao.UserDao;

/** Handles the persisting of new users signing up with google */
@Service
public class GoogleSignupService {
	
	@Autowired
	private UserDao userDao;

	/** Handles persisting a new user to the database. */
	@Transactional
	public void saveFrom(GoogleSignupForm googleForm) {
		User user = new User();
		user.setUsername(googleForm.getEmail());
		user.setEmail(googleForm.getEmail());
		user.setFirstName(googleForm.getFirstName());
		user.setLastName(googleForm.getLastName());
		
		final SecureRandom rndm = new SecureRandom();
		String randomPassword = new BigInteger(130, rndm).toString(32);
		user.setPassword(randomPassword); //sets a strong random password
		
		user.setEnabled(true);
		user.setGender(Gender.OTHER);
		user.setIsGoogleUser(true);
		
		user.setKindOfMembership(KindOfMembership.NORMAL);
		
		userDao.save(user);
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
