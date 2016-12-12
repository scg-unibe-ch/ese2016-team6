package ch.unibe.ese.team6.test.testData;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ch.unibe.ese.team6.model.Alert;
import ch.unibe.ese.team6.model.User;
import ch.unibe.ese.team6.model.dao.AlertDao;
import ch.unibe.ese.team6.model.dao.UserDao;

/**
 * This inserts some alert test data into the database.
 */
@Service
public class AlertTestDataSaver {

	@Autowired
	private AlertDao alertDao;
	
	@Autowired
	private UserDao userDao;


	@Transactional
	public void saveTestData() throws Exception {
		User ese = userDao.findByUsername("ese@unibe.ch");
		User jane = userDao.findByUsername("jane@doe.com");

		// 2 Alerts for the ese test-user
		Alert alert = new Alert();
		alert.setUser(ese);
		alert.setCity("Bern");
		alert.setZipcode(3000);
		alert.setForRent(true);
		alert.setPriceRent(1500);
		alert.setRadius(30);
		alert.setNumberOfRooms(3);
		alert.setMinSize(0);
		alert.setMaxSize(1000000);
		alertDao.save(alert);
		
		alert = new Alert();
		alert.setUser(ese);
		alert.setCity("Zürich");
		alert.setZipcode(8000);
		alert.setPriceRent(1000);
		alert.setRadius(25);
		alert.setForRent(true);
		alert.setNumberOfRooms(2);
		alert.setMinSize(0);
		alert.setMaxSize(1000000);
		alertDao.save(alert);
		
		
		// One alert for Jane Doe
		alert = new Alert();
		alert.setUser(jane);
		alert.setCity("Luzern");
		alert.setZipcode(6003);
		alert.setPriceRent(900);
		alert.setRadius(22);
		alert.setForRent(true);
		alert.setNumberOfRooms(2);
		alert.setMinSize(0);
		alert.setMaxSize(1000000);
		alertDao.save(alert);
	}

}
