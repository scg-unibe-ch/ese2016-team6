package ch.unibe.ese.team6.controller.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import ch.unibe.ese.team6.controller.pojos.forms.PlaceAdForm;
import ch.unibe.ese.team6.controller.pojos.forms.SearchForm;
import ch.unibe.ese.team6.controller.service.AdService;
import ch.unibe.ese.team6.model.Ad;
import ch.unibe.ese.team6.model.Gender;
import ch.unibe.ese.team6.model.KindOfMembership;
import ch.unibe.ese.team6.model.User;
import ch.unibe.ese.team6.model.UserRole;
import ch.unibe.ese.team6.model.Visit;
import ch.unibe.ese.team6.model.dao.UserDao;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/config/springMVC.xml",
		"file:src/main/webapp/WEB-INF/config/springData.xml",
		"file:src/main/webapp/WEB-INF/config/springSecurity.xml"})
@WebAppConfiguration
public class AdServiceTest {

	@Autowired
	private AdService adService;
	
	@Autowired
	private UserDao userDao;

	/**
	 * In order to test the saved ad, I need to get it back from the DB again, so these
	 * two methods need to be tested together, normally we want to test things isolated of
	 * course. Testing just the returned ad from saveFrom() wouldn't answer the question 
	 * whether the ad has been saved correctly to the db.
	 * @throws ParseException 
	 */
	@Test
	public void saveFromAndGetById() throws ParseException {
		//Preparation
		PlaceAdForm placeAdForm = new PlaceAdForm();
		placeAdForm.setForRent(true);
		placeAdForm.setCity("7532 - Tschierv");
		placeAdForm.setPreferences("Test preferences");
		placeAdForm.setRoomDescription("Test Room description");
		//placeAdForm.setRoommates("Test Roommate description");
		placeAdForm.setPriceRent(600);
		placeAdForm.setSquareFootage(50);
		placeAdForm.setTitle("title");
		placeAdForm.setStreet("Hauptstrasse 13");
	//	placeAdForm.setStudio(true);
		placeAdForm.setMoveInDate("27-02-2016");
		placeAdForm.setMoveOutDate("27-04-2017");
		placeAdForm.setNumberOfRooms(3);
		
		placeAdForm.setDeadlineDate("30-04-2017");
		placeAdForm.setDeadlineHour("13");
		placeAdForm.setDeadlineMinute("30");
		
		placeAdForm.setSmokers(true);
		placeAdForm.setAnimals(false);
		placeAdForm.setGarden(true);
		placeAdForm.setBalcony(false);
		placeAdForm.setCellar(true);
		placeAdForm.setFurnished(false);
		placeAdForm.setCable(false);
		placeAdForm.setGarage(true);
		placeAdForm.setInternet(false);
		placeAdForm.setMembershipUser(KindOfMembership.NORMAL);
		placeAdForm.setProximityToPublicTransport(100);
		placeAdForm.setProximityToSchool(200);
		placeAdForm.setProximityToNightlife(300);
		placeAdForm.setProximityToSupermarket(400);
		
		List<String> visits = new ArrayList<String>();
		visits.add("28-02-2014;10:02;13:14");
		placeAdForm.setVisits(visits);
		
		ArrayList<String> filePaths = new ArrayList<>();
		filePaths.add("/img/test/ad1_1.jpg");
		
		User hans = createUser("hans@kanns.ch", "password", "Hans", "Kanns",
				Gender.MALE, KindOfMembership.NORMAL);
		hans.setAboutMe("Hansi Hinterseer");
		userDao.save(hans);
		
		adService.saveFrom(placeAdForm, filePaths, hans);
		
		Ad ad = new Ad();
		Iterable<Ad> ads = adService.getAllAds();
		Iterator<Ad> iterator = ads.iterator();
		
		while (iterator.hasNext()) {
			ad = iterator.next();
		}
		
		//Testing
		assertTrue(ad.getRent());
		assertTrue(ad.getSmokers());
		assertFalse(ad.getAnimals());
		assertEquals("Tschierv", ad.getCity());
		assertEquals(7532, ad.getZipcode());
		assertEquals("Test preferences", ad.getPreferences());
		assertEquals("Test Room description", ad.getRoomDescription());
	//	assertEquals("Test Roommate description", ad.getRoommates());
		assertEquals(600, ad.getPriceRent());
		assertEquals(50, ad.getSquareFootage());
		assertEquals("title", ad.getTitle());
		assertEquals("Hauptstrasse 13", ad.getStreet());
		assertEquals(100, ad.getProximityToPublicTransport());
		assertEquals(200, ad.getProximityToSchool());
		assertEquals(300, ad.getProximityToNightlife());
		assertEquals(400, ad.getProximityToSupermarket());
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    Date result1 =  df.parse("2016-02-27");
	    df = new SimpleDateFormat("yyyy-MM-dd");
	    Date result2 =  df.parse("2017-04-27");
		assertEquals(0, result1.compareTo(ad.getMoveInDate()));
		assertEquals(0, result2.compareTo(ad.getMoveOutDate()));
		
		List<Visit> vs = ad.getVisits();
		assertEquals(1, vs.size());
		Visit v = vs.get(0);
		
		Visit visit = new Visit();
		visit.setAd(ad);
		DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm");
		visit.setStartTimestamp(dateFormat.parse("28-02-2014 10:02"));
		visit.setEndTimestamp(dateFormat.parse("28-02-2014 13:14"));
		assertEquals(visit.getAd(), v.getAd());
		assertEquals(visit.getStartTimestamp(), v.getStartTimestamp());
		assertEquals(visit.getEndTimestamp(), v.getEndTimestamp());
		
		ads = adService.getNewestAds(1);
		assertEquals(1, size(ads));
		
		ads = adService.getNewestRentAds(1, true);
		assertEquals(1, size(ads));
		

		// query results test
		SearchForm form = new SearchForm();
		
		form.setAnimals(false);
		form.setBalcony(false);
		form.setCable(false);
		form.setCellar(false);
		form.setFurnished(false);
		form.setGarage(false);
		form.setGarden(false);
		form.setInternet(false);
		form.setSmokers(false);
		form.setRent(true);
		form.setForRent(true);
		form.setForSale(false);
		form.setFiltered(false);
		form.setPriceRent(1000);
		form.setKindOfMembershipUser(false);
		form.setCity("7532 - Tschierv");
		form.setNumberOfRooms(1);
		form.setProximityToNightlife(1000);
		form.setProximityToPublicTransport(1000);
		form.setProximityToSchool(1000);
		form.setProximityToSupermarket(1000);
		form.setRadius(10);
		ads = adService.queryResults(form);
		assertEquals(1, size(ads));
		
		form.setForSale(true);
		form.setForRent(false);
		form.setRent(false);
		ads = adService.queryResults(form);
		assertEquals(0, size(ads));
		
		form.setForSale(false);
		form.setForRent(true);
		form.setRent(true);
		form.setPriceRent(500);
		ads = adService.queryResults(form);
		assertEquals(0, size(ads));
		
		form.setFiltered(true);
		form.setPriceRent(1000);
		form.setSmokers(true);
		ads = adService.queryResults(form);
		assertEquals(1, size(ads));
		
		form.setSmokers(false);
		form.setAnimals(true);
		ads = adService.queryResults(form);
		assertEquals(0, size(ads));
		
		form.setAnimals(false);
		form.setBalcony(true);
		ads = adService.queryResults(form);
		assertEquals(0, size(ads));
		
		form.setBalcony(false);
		form.setGarden(true);
		ads = adService.queryResults(form);
		assertEquals(1, size(ads));
		
		form.setGarden(false);
		form.setGarage(true);
		ads = adService.queryResults(form);
		assertEquals(1, size(ads));
		
		form.setGarage(false);
		form.setCable(true);
		ads = adService.queryResults(form);
		assertEquals(0, size(ads));
		
		form.setCable(false);
		form.setFurnished(true);
		ads = adService.queryResults(form);
		assertEquals(0, size(ads));
		
		form.setFurnished(false);
		form.setInternet(true);
		ads = adService.queryResults(form);
		assertEquals(0, size(ads));
		
		form.setInternet(false);
		form.setProximityToPublicTransport(50);
		ads = adService.queryResults(form);
		assertEquals(0, size(ads));
		
		form.setProximityToPublicTransport(1000);
		form.setProximityToNightlife(50);
		ads = adService.queryResults(form);
		assertEquals(0, size(ads));
		
		form.setProximityToNightlife(1000);
		form.setProximityToSchool(50);
		ads = adService.queryResults(form);
		assertEquals(0, size(ads));
		
		form.setProximityToSchool(1000);
		form.setProximityToSupermarket(50);
		ads = adService.queryResults(form);
		assertEquals(0, size(ads));
		
		form.setProximityToSupermarket(1000);
		form.setCellar(true);
		ads = adService.queryResults(form);
		assertEquals(1, size(ads));
	}
	
	private User createUser(String email, String password, String firstName,
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
	
	private int size(Iterable<Ad> ads) {
		int i=0;
		Iterator<Ad> iterator = ads.iterator();
		while (iterator.hasNext()) {
			iterator.next();
			i++;
		}
		return i;
	}
	
}
