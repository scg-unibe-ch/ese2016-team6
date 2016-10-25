package ch.unibe.ese.team6.controller.service;

import java.util.Date;
import java.util.HashSet;
import java.util.Properties;
import java.util.Set;
import java.util.*;

import javax.mail.MessagingException;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ch.unibe.ese.team6.controller.pojos.forms.SignupForm;
import ch.unibe.ese.team6.model.User;
import ch.unibe.ese.team6.model.UserRole;
import ch.unibe.ese.team6.model.dao.MessageDao;
import ch.unibe.ese.team6.model.dao.UserDao;
import ch.unibe.ese.team6.model.KindOfMembership;
import ch.unibe.ese.team6.model.Message;
import ch.unibe.ese.team6.model.MessageState;

/** Handles the persisting of new users */
@Service
public class SignupService {
	
	private static final String DEFAULT_ROLE = "ROLE_USER";
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private MessageDao messageDao;

	/** Handles persisting a new user to the database. */
	@Transactional
	public void saveFrom(SignupForm signupForm) {
		User user = new User();
		user.setUsername(signupForm.getEmail());
		user.setEmail(signupForm.getEmail());
		user.setFirstName(signupForm.getFirstName());
		user.setLastName(signupForm.getLastName());
		user.setPassword(signupForm.getPassword());
		user.setEnabled(true);
		user.setGender(signupForm.getGender());
		user.setKindOfMembership(signupForm.getKindOfMembership());
		
		Set<UserRole> userRoles = new HashSet<>();
		UserRole role = new UserRole();
		role.setRole(DEFAULT_ROLE);
		role.setUser(user);
		userRoles.add(role);
		
		user.setUserRoles(userRoles);
		
		userDao.save(user);
		
		if(user.getKindOfMembership().equals(KindOfMembership.PREMIUM)) {
			Timer timer = new Timer();
			timer.schedule(sendPayMessage(user), 1000);
			sendPayMessage(user);
		}
	}
	
	/*
	 * sends a Message to the new Member that he has to pay for his Premiummembership
	 * 
	 * @param: user
	 */
	public void sendPayMessage(User user) {
		User sender = userDao.findByUsername("System");
		String sub = "Welcome to Flatfindr!";
		String txt = "You have to pay " + user.getPriceForPremiumMembereship() 
		+ " CHF on our bank account!";
		
		//sends message
		Message message = new Message();
		message.setDateSent(new Date());
		message.setSender(sender);
		message.setRecipient(user);
		message.setSubject(sub);
		message.setText(txt);
		message.setState(MessageState.UNREAD);
		
		messageDao.save(message);
		
		//sends email
		Properties properties = System.getProperties();
		properties.setProperty("mail.smtp.host", "localhost");
		javax.mail.Session session = javax.mail.Session.getInstance(properties);
		try {
			MimeMessage mess = new MimeMessage(session);
			mess.setFrom(new InternetAddress(sender.getEmail()));
			mess.addRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(user.getEmail(), false));
			mess.setSubject(sub);
			mess.setText(txt);

			Transport.send(mess);
			System.out.println("Sent message successfully....");
			}catch (MessagingException mex) {
				mex.printStackTrace();
			}
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

private class Timer extends TimerTask {
	public void run(User user){
		sendPayMessage(user);
	}
}
