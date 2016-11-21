package ch.unibe.ese.team6.controller.service;

import java.util.Timer;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ch.unibe.ese.team6.controller.pojos.forms.EditProfileForm;
import ch.unibe.ese.team6.model.KindOfMembership;
import ch.unibe.ese.team6.model.User;
import ch.unibe.ese.team6.model.dao.UserDao;
import ch.unibe.ese.team6.controller.service.SignupService;

/** Handles updating a user's profile. */
@Service
public class UserUpdateService {
	
	@PersistenceContext
	private EntityManager entityManager;
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private SignupService signupService;

	/** Handles updating an existing user in the database. */
	@Transactional
	public void updateFrom(EditProfileForm editProfileForm, User user, KindOfMembership kind) {
		
		user.setUsername(editProfileForm.getUsername());
		user.setFirstName(editProfileForm.getFirstName());
		user.setLastName(editProfileForm.getLastName());
		user.setPassword(editProfileForm.getPassword());
		user.setAboutMe(editProfileForm.getAboutMe());
		user.setKindOfMembership(editProfileForm.getKindOfMembership());
		user.setEmail(editProfileForm.getUsername());

		userDao.save(user);
		
		if(!kind.equals(user.getKindOfMembership())) {
			if(user.getKindOfMembership().equals((KindOfMembership.PREMIUM))) {
				signupService.timer2.purge();
				signupService.timer = new Timer();
				signupService.sendPayMessage(user);
			} else {
				signupService.timer.purge();
				signupService.timer2 = new Timer();
				signupService.sendsMessageAndEmailForNormalUserWeekly(user);
			}
		}	
	}
}
