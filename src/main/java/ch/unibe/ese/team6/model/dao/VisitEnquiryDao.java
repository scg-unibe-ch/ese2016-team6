package ch.unibe.ese.team6.model.dao;

import org.springframework.data.repository.CrudRepository;

import ch.unibe.ese.team6.model.User;
import ch.unibe.ese.team6.model.VisitEnquiry;

public interface VisitEnquiryDao extends CrudRepository<VisitEnquiry, Long> {
	public static Iterable<VisitEnquiry> findBySender(User sender) {
		// TODO Auto-generated method stub
		return null;
	}
	
}