package ch.unibe.ese.team6.controller.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.lang.Math;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ch.unibe.ese.team6.controller.pojos.forms.AlertForm;
import ch.unibe.ese.team6.model.Ad;
import ch.unibe.ese.team6.model.Alert;
import ch.unibe.ese.team6.model.KindOfDeal;
import ch.unibe.ese.team6.model.Message;
import ch.unibe.ese.team6.model.MessageState;
import ch.unibe.ese.team6.model.User;
import ch.unibe.ese.team6.model.dao.AlertDao;
import ch.unibe.ese.team6.model.dao.MessageDao;
import ch.unibe.ese.team6.model.dao.UserDao;
import ch.unibe.ese.team6.model.util.Location;

/**
 * Provides and handles persistence operations for adding, editing and deleting
 * alerts.
 */
@Service
public class AlertService {

	@Autowired
	UserDao userDao;

	@Autowired
	AlertDao alertDao;

	@Autowired
	MessageDao messageDao;

	@Autowired
	private GeoDataService geoDataService;

	/**
	 * Persists a new alert with the data from the alert form to the database.
	 * 
	 * @param alertForm
	 *            the form to take the data from
	 * @param user
	 *            the user to associate the new alert to
	 */
	@Transactional
	public void saveFrom(AlertForm alertForm, User user) {
		Alert alert = new Alert();

		String zip = alertForm.getCity().substring(0, 4);
		alert.setZipcode(Integer.parseInt(zip));
		alert.setCity(alertForm.getCity().substring(7));
		alert.setRadius(alertForm.getRadius());
		alert.setUser(user);
		alert.setForRent(alertForm.getForRent());
		alert.setForSale(alertForm.getForSale());
		if(alert.getForRent()) {
			alert.setPriceRent(alertForm.getPrice());
		} else if(alert.getForSale()){
			alert.setPriceSale(alertForm.getPrice());
		} else {
			alert.setPriceRent(alertForm.getPrice());
			alert.setPriceSale(alertForm.getPrice());
		}
		alert.setMinSize(alertForm.getMinSize());
		alert.setMaxSize(alertForm.getMaxSize());
		alert.setIsValid(alertForm.getIsValid());
		alert.setNumberOfRooms(alertForm.getNumberOfRooms());
		alertDao.save(alert);
	}

	/**
	 * Returns all alerts that belong to the given user.
	 */
	@Transactional
	public Iterable<Alert> getAlertsByUser(User user) {
		return alertDao.findByUser(user);
	}

	/** Deletes the alert with the given id. */
	@Transactional
	public void deleteAlert(Long id) {
		alertDao.delete(id);
	}

	/**
	 * Triggers all alerts that match the given ad. For every user, only one
	 * message is sent.
	 */
	@Transactional
	public void triggerAlerts(Ad ad) {
		
		/*
		 * There is an error here that causes a crash. a null pointer or index out of bounds error.
		 * Was because it still checked for the Room and Studios in the add.
		 */
		
		int adPrice = ad.getPriceRent(); //ad.getPrizePerMonth removed from Ad.java
		int adPriceSale = ad.getPriceSale();
		Iterable<Alert> alerts = alertDao.findByPriceRentGreaterThanAndPriceSaleGreaterThan(adPrice - 1, adPriceSale-1);
		
		

		// loop through all ads with matching city and price range, throw out
		// mismatches
		Iterator<Alert> alertIterator = alerts.iterator();
		while (alertIterator.hasNext()) {
			Alert alert = alertIterator.next();
			if (rentSaleMismatchWith(ad, alert)
					|| radiusMismatchWith(ad, alert)
					|| ad.getUser().equals(alert.getUser())
					|| sizeMismatchWith(ad, alert)
					|| ad.getNumberOfRooms() < alert.getNumberOfRooms() )
				alertIterator.remove();
		}

		
		// send only one message per user, no matter how many alerts were
		// triggered
		List<User> users = new ArrayList<User>();
		for (Alert alert : alerts) {
			User user = alert.getUser();
			if (!users.contains(user)) {
				users.add(user);
			}
		}

		// send messages to all users with matching alerts
		for (User user : users) {
			Date now = new Date();
			Message message = new Message();
			message.setSubject("It's a match!");
			message.setText(getAlertText(ad));
			message.setSender(userDao.findByUsername("System"));
			message.setRecipient(user);
			message.setState(MessageState.UNREAD);
			message.setDateSent(now);
			messageDao.save(message);
		}
	}

	/**
	 * Returns the text for an alert message with the properties of the given
	 * ad.
	 */
	private String getAlertText(Ad ad) {
		return "Dear user,<br>good news. A new ad matching one of your alerts has been "
				+ "entered into our system. You can visit it here:<br><br>"
				+ "<a class=\"link\" href=/ad?id="
				+ ad.getId()
				+ ">"
				+ ad.getTitle()
				+ "</a><br><br>"
				+ "Good luck and enjoy,<br>"
				+ "Your HomeLender crew";
	}
	
	/** Checks if an ad is conforming to the criteria in an alert. */
	private boolean rentSaleMismatchWith(Ad ad, Alert alert) {
		boolean mismatch = false;
		if (//(ad.getDeal() == KindOfDeal.forRent ) != alert.getForRent()
				ad.getRent() != alert.getForRent())
			mismatch = true;
		return mismatch;
	}
	
	/** Checks if an ad has the size specified in the alert **/
	private boolean sizeMismatchWith(Ad ad, Alert alert) {
		if (alert.getMinSize() > ad.getSquareFootage()) {
			return true;
		}
		if (alert.getMaxSize() < ad.getSquareFootage()) {
			return true;
		}
		return false;
	}

	/**
	 * Checks whether an ad is for a place too far away from the alert.
	 * 
	 * @param ad
	 *            the ad to compare to the alert
	 * @param alert
	 *            the alert to compare to the ad
	 * 
	 * @return true in case the alert does not match the ad (the ad is too far
	 *         away), false otherwise
	 */
	private boolean radiusMismatchWith(Ad ad, Alert alert) {
		final int earthRadiusKm = 6380;
		Location adLocation = geoDataService.getLocationsByCity(ad.getCity())
				.get(0);
		Location alertLocation = geoDataService.getLocationsByCity(
				alert.getCity()).get(0);

		double radSinLat = Math.sin(Math.toRadians(adLocation.getLatitude()));
		double radCosLat = Math.cos(Math.toRadians(adLocation.getLatitude()));
		double radLong = Math.toRadians(adLocation.getLongitude());
		double radLongitude = Math.toRadians(alertLocation.getLongitude());
		double radLatitude = Math.toRadians(alertLocation.getLatitude());
		double distance = Math.acos(radSinLat * Math.sin(radLatitude)
				+ radCosLat * Math.cos(radLatitude)
				* Math.cos(radLong - radLongitude))
				* earthRadiusKm;
		return (distance > alert.getRadius());
	}
	
	//for testing
	public boolean radiusMismatch(Ad ad, Alert alert) {
		return radiusMismatchWith(ad, alert);
	}
	
	public boolean rentSaleMismatch(Ad ad, Alert alert) {
		return rentSaleMismatchWith(ad, alert);
	}
	
	public boolean sizeMismatch(Ad ad, Alert alert) {
		return sizeMismatchWith(ad, alert);
	}
}