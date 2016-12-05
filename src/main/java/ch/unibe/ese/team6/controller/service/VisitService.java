package ch.unibe.ese.team6.controller.service;

import java.util.ArrayList;
import java.util.Iterator;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ch.unibe.ese.team6.model.Ad;
import ch.unibe.ese.team6.model.User;
import ch.unibe.ese.team6.model.dao.UserDao;
import ch.unibe.ese.team6.model.Visit;
import ch.unibe.ese.team6.model.VisitEnquiry;
import ch.unibe.ese.team6.model.VisitEnquiryState;
import ch.unibe.ese.team6.model.dao.VisitDao;
import ch.unibe.ese.team6.model.dao.VisitEnquiryDao;

/** Provides operations for getting and saving visits */
@Service
public class VisitService {

	@Autowired
	private VisitDao visitDao;
	
	@Autowired
	private UserDao userDao;

	@Autowired
	VisitEnquiryDao visitEnquiryDao;

	/**
	 * Returns all possible visits of an advertisement.
	 * 
	 * @return an Iterable of all matching visits
	 */
	@Transactional
	public Iterable<Visit> getVisitsByAd(Ad ad) {
		return visitDao.findByAd(ad);
	}

	/** Returns the visit with the given id. */
	@Transactional
	public Visit getVisitById(long id) {
		return visitDao.findOne(id);
	}

	/** Returns all visits that a user has applied for and was also accepted to. */
	@Transactional
	public Iterable<Visit> getVisitsForUser(User user) {
		// all enquiries sent by user
		Iterable<VisitEnquiry> usersEnquiries = visitEnquiryDao
				.findBySender(user);
		// all visits user has been accepted for
		ArrayList<Visit> usersVisits = new ArrayList<Visit>();
		// fill the list
		for (VisitEnquiry enquiry : usersEnquiries) {
			if (enquiry.getState() == VisitEnquiryState.ACCEPTED)
				(usersVisits).add(enquiry.getVisit());
		}
		return usersVisits;
	}
	
	/** Returns true if the user has sent an enquiry for the visit, false otherwise */
	public boolean hasUserSentEnquiry(User user, Visit visit) {		
		Iterable<VisitEnquiry> usersEnquiries = visitEnquiryDao.findBySender(user);
		ArrayList<Visit> visits = new ArrayList<Visit>();
		for (VisitEnquiry enquiry : usersEnquiries) {
				visits.add(enquiry.getVisit());
		}
		
		Iterator<Visit> it = visits.iterator();
		while (it.hasNext()) {
			if (visit.getId() == it.next().getId()) {
				return true;
			}
		}
		return false;
	}
	
	public boolean hasUserSentEnquiry(String username, Visit visit) {
		User user = userDao.findByUsername(username);
		return hasUserSentEnquiry(user, visit);
	}

	/** Returns all visitors for the visit with the given id. */
	public Iterable<User> getVisitorsForVisit(long id) {
		Visit visit = visitDao.findOne(id);
		return visit.getSearchers();
	}
}
