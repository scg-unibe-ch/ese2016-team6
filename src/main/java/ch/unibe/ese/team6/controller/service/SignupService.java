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
import ch.unibe.ese.team6.model.dao.AdDao;
import ch.unibe.ese.team6.model.dao.MessageDao;
import ch.unibe.ese.team6.model.dao.UserDao;
import ch.unibe.ese.team6.model.Ad;
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
	
	@Autowired
	private AdDao adDao;

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
			sendPayMessage(user);
			Timer timer = new Timer();
			timer.schedule(new PayMessager(user), user.getPeriodOfPreiumMembership());
		}
		if(user.getKindOfMembership().equals(KindOfMembership.NORMAL)) {
			sendsMessageAndEmailForNormalUserWeekly(user);
			Timer timer2 = new Timer();
			timer2.schedule(new WeeklyEmail(user), 60000); //would be for a week: 60000*60*24*7 but to test its: 60000 = 1 Minute
		}
	}
	
	// Timer for the Pay Reminder for the Premium Members
	class PayMessager extends TimerTask {
		User user;
		
		public PayMessager(User user) {
			this.user = user;
		}

		@Override
		public void run() {
			sendPayMessage(user);	
		}
	}
	
	// Timer for the Weekly Summary of the Ads of last week
	class WeeklyEmail extends TimerTask {
		User user;
		
		public WeeklyEmail(User user) {
			this.user = user;
		}
		
		@Override
		public void run() {
			sendsMessageAndEmailForNormalUserWeekly(user);
		}
	}
	
	/*
	 * sends a Message to the new Member that he has to pay for his Premiummembership
	 * 
	 * @param: user
	 */
	public void sendPayMessage(User user) {
		String sub = "Welcome to Flatfinder!";
		String txt = "You have to pay " + user.getPriceForPremiumMembereship() 
		+ " CHF into our bank account for the Premium Membership!";
		
		sendMessage(user, sub, txt);
		sendEmail(user, sub, txt);
	}
	
	/*
	 * sends Weekly a summary of all Ads from the last week
	 */
	public void sendsMessageAndEmailForNormalUserWeekly(User user) {
		String sub = "These are the Ads from last week!";
		String txt = "Adds: ";
		
		Date dateNow = new Date();
		Date date7DaysAgo = new Date();
		Calendar c = Calendar.getInstance();
		c.setTime(dateNow);
		c.add(Calendar.DATE, -7);
		date7DaysAgo.setTime(c.getTime().getTime());

		for(Ad ad: adDao.findAll()) {
			if(ad.getCreationDate().after(date7DaysAgo)) {
				txt += "</a><br><br> <a class=\"link\" href=/ad?id="
			 			+ ad.getId() + ">" + ad.getTitle() + "</a><br><br>";
			}
		}
		
		if(txt.equals("Adds: ")) {
			txt = "There are no new Ads, but check out our Page!";
		}
		
		sendMessage(user, sub, txt);
		sendEmail(user, sub, txt);
	}
	
	//sends message
	public void sendMessage(User recipient, String sub, String tex) {
		Message message = new Message();
		message.setDateSent(new Date());
		message.setSender(userDao.findByUsername("System"));
		message.setRecipient(recipient);
		message.setSubject(sub);
		message.setText(tex);
		message.setState(MessageState.UNREAD);
		
		messageDao.save(message);
	}
	
	//sends email
	public void sendEmail(User recipient, String sub, String tex) {
		Properties properties = System.getProperties();
		properties.setProperty("mail.smtp.host", "smtp.unibe.ch");
		javax.mail.Session session = javax.mail.Session.getInstance(properties);
		try {
			MimeMessage mess = new MimeMessage(session);
			mess.setFrom(new InternetAddress("valerie.haftka@students.unibe.ch")); // userDao.findByUsername("System").getEmail())
			mess.addRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(recipient.getEmail(), false));
			mess.setSubject(sub);
			mess.setText(tex);

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
