package ch.unibe.ese.team6.controller.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import ch.unibe.ese.team6.controller.pojos.forms.AlertForm;
import ch.unibe.ese.team6.controller.service.AlertService;
import ch.unibe.ese.team6.model.Ad;
import ch.unibe.ese.team6.model.Alert;
import ch.unibe.ese.team6.model.Gender;
import ch.unibe.ese.team6.model.KindOfMembership;
import ch.unibe.ese.team6.model.Message;
import ch.unibe.ese.team6.model.User;
import ch.unibe.ese.team6.model.UserRole;
import ch.unibe.ese.team6.model.dao.AdDao;
import ch.unibe.ese.team6.model.dao.AlertDao;
import ch.unibe.ese.team6.model.dao.MessageDao;
import ch.unibe.ese.team6.model.dao.UserDao;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/config/springMVC.xml",
		"file:src/main/webapp/WEB-INF/config/springData.xml",
		"file:src/main/webapp/WEB-INF/config/springSecurity.xml"})
@WebAppConfiguration
public class AlertServiceTest {
	
	@Autowired
	AdDao adDao;
	
	@Autowired
	UserDao userDao;
	
	@Autowired
	AlertDao alertDao;
	
	@Autowired
	MessageDao messageDao;
	
	@Autowired
	AlertService alertService;
	
	@Test
	public void createAlerts() {
		ArrayList<Alert> alertList = new ArrayList<Alert>();
		
		// Create user Adolf Ogi
		User adolfOgi = createUser("adolf@ogi.ch", "password", "Adolf", "Ogi",
				Gender.MALE, KindOfMembership.NORMAL);
		adolfOgi.setAboutMe("Wallis rocks");
		userDao.save(adolfOgi);
		
		// Create 2 alerts for Adolf Ogi
		Alert alert = new Alert();
		alert.setUser(adolfOgi);
		alert.setCity("Bern");
		alert.setZipcode(3000);
		alert.setForRent(true);
		alert.setPriceRent(1500);
		alert.setRadius(100);
		alertDao.save(alert);
		
		alert = new Alert();
		alert.setUser(adolfOgi);
		alert.setCity("Bern");
		alert.setZipcode(3002);
		alert.setForRent(true);
		alert.setPriceRent(1000);
		alert.setRadius(5);
		alertDao.save(alert);
		
		//copy alerts to a list
		Iterable<Alert> alerts = alertService.getAlertsByUser(adolfOgi);
		for(Alert returnedAlert: alerts)
			alertList.add(returnedAlert);
		
		//begin the actual testing
		assertEquals(2, alertList.size());
		assertEquals(adolfOgi, alertList.get(0).getUser());
		assertEquals("Bern", alertList.get(1).getCity());
		assertTrue(alertList.get(0).getRadius() > alertList.get(1).getRadius());
		
		AlertForm form = new AlertForm();
		form.setCity("3002 - Bern");
		form.setForRent(true);
		form.setForSale(false);
		form.setMaxSize(300);
		form.setMinSize(5);
		form.setNumberOfRooms(1);
		form.setPrice(1000);
		form.setUser(adolfOgi);
		form.setZipCode(3002);
		form.setIsValid(true);
		form.setRadius(10);
		alertService.saveFrom(form, adolfOgi);
		
		alerts = alertService.getAlertsByUser(adolfOgi);
		alertList = new ArrayList<Alert>();
		for(Alert returnedAlert: alerts)
			alertList.add(returnedAlert);
		
		assertEquals(3, alertList.size());
		assertEquals(adolfOgi, alertList.get(2).getUser());
		assertEquals("Bern", alertList.get(2).getCity());
		assertEquals(10, alertList.get(2).getRadius());
		assertEquals(5, alertList.get(2).getMinSize());
		assertEquals(300, alertList.get(2).getMaxSize());
		assertTrue(alertList.get(2).getForRent());
		assertEquals(1, alertList.get(2).getNumberOfRooms());
		assertEquals(1000, alertList.get(2).getPriceRent());
	}
	
	@Test
	public void mismatchChecks() {
		ArrayList<Alert> alertList = new ArrayList<Alert>();
		
		User thomyF = createUser("thomy@f.ch", "password", "Thomy", "F",
				Gender.MALE, KindOfMembership.NORMAL);
		thomyF.setAboutMe("Supreme hustler");
		userDao.save(thomyF);
		
		User thomyG = createUser("thomy@g.ch", "password", "Thomy", "G",
				Gender.MALE, KindOfMembership.NORMAL);
		thomyG.setAboutMe("Supreme hustler");
		userDao.save(thomyG);
		
		// Create 2 alerts for Thomy F
		Alert alert = new Alert();
		alert.setUser(thomyF);
		alert.setCity("Bern");
		alert.setZipcode(3000);
		alert.setForRent(true);
		alert.setForSale(false);
		alert.setPriceRent(3000);
		alert.setRadius(100);
		alert.setMinSize(10);
		alert.setMaxSize(100);
		alert.setNumberOfRooms(2);
		alertDao.save(alert);
		
		alert = new Alert();
		alert.setUser(thomyF);
		alert.setCity("Bern");
		alert.setZipcode(3002);
		alert.setForSale(true);
		alert.setForRent(false);
		alert.setPriceSale(3000);
		alert.setRadius(5);
		alert.setMinSize(10);
		alert.setMaxSize(40);
		alert.setNumberOfRooms(2);
		alertDao.save(alert);
		
		Iterable<Alert> alerts = alertService.getAlertsByUser(userDao.findByUsername("thomy@f.ch"));
		for(Alert returnedAlert: alerts)
			alertList.add(returnedAlert);
		
		//save an ad
		Date date = new Date();
		Ad oltenResidence= new Ad();
		oltenResidence.setRent(true);
		oltenResidence.setNumberOfRooms(4);
		oltenResidence.setZipcode(4600);
		oltenResidence.setMoveInDate(date);
		oltenResidence.setCreationDate(date);
		oltenResidence.setPriceRent(1200);
		oltenResidence.setSquareFootage(42);
		oltenResidence.setStudio(false);
		oltenResidence.setSmokers(true);
		oltenResidence.setAnimals(false);
		oltenResidence.setRoomDescription("blah");
		oltenResidence.setPreferences("blah");
	//	oltenResidence.setRoommates("None");
		oltenResidence.setUser(thomyG);
		oltenResidence.setTitle("Olten Residence");
		oltenResidence.setStreet("Florastr. 100");
		oltenResidence.setCity("Olten");
		oltenResidence.setGarden(false);
		oltenResidence.setBalcony(false);
		oltenResidence.setCellar(false);
		oltenResidence.setFurnished(false);
		oltenResidence.setCable(false);
		oltenResidence.setGarage(false);
		oltenResidence.setInternet(false);
		adDao.save(oltenResidence);
		
		assertFalse(alertService.radiusMismatch(oltenResidence, alertList.get(0)));
		assertTrue(alertService.radiusMismatch(oltenResidence, alertList.get(1)));
		assertFalse(alertService.rentSaleMismatch(oltenResidence, alertList.get(0)));
		assertTrue(alertService.rentSaleMismatch(oltenResidence, alertList.get(1)));
		assertFalse(alertService.sizeMismatch(oltenResidence, alertList.get(0)));
		assertTrue(alertService.sizeMismatch(oltenResidence, alertList.get(1)));

		alertService.triggerAlerts(oltenResidence);
		Iterable<Message> messages = messageDao.findByRecipient(userDao.findByUsername("thomy@f.ch"));
		int m = size(messages);
		assertEquals(1, m);
		
		}
	
	//Lean user creating method
	User createUser(String email, String password, String firstName,
			String lastName, Gender gender, KindOfMembership kind) {
		User user = new User();
		user.setUsername(email);
		user.setPassword(password);
		user.setEmail(email);
		user.setFirstName(firstName);
		user.setLastName(lastName);
		user.setEnabled(true);
		user.setGender(gender);
		user.setKindOfMembership(kind);
		Set<UserRole> userRoles = new HashSet<>();
		UserRole role = new UserRole();
		role.setRole("ROLE_USER");
		role.setUser(user);
		userRoles.add(role);
		user.setUserRoles(userRoles);
		return user;
	}
	
	private int size(Iterable<Message> m) {
		Iterator<Message> it = m.iterator();
		int i=0;
		while (it.hasNext()) {
			it.next();
			i++;
		}
		return i;
	}
}
